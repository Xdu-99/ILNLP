#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;

use ilnlp::{ilasp::ILTask, stat::Stat};
use std::{
    fmt::Display,
    fs::File,
    io::{BufReader, BufWriter, Read, Write, stdin, stdout},
    path::PathBuf,
    process::{Command, Child},
    sync::{Arc, Mutex},
    time::Duration,
};
use tempfile::NamedTempFile;
use sysinfo::{Pid, ProcessesToUpdate, System};
use clap::Parser;

#[derive(Parser)]
#[command(about, long_about = None, disable_version_flag = true)]
struct Cli {
    input: Option<PathBuf>,
    #[arg(short, long)]
    output: Option<PathBuf>,
    #[arg(long, default_value = "ILASP")]
    ilasp: PathBuf,
    #[arg(long)]
    template: Option<PathBuf>,
    #[arg(long)]
    ilasp_out: Option<PathBuf>,
    #[arg(short, long)]
    run: bool,
    #[arg(long, action = clap::ArgAction::Append, value_parser = clap::builder::NonEmptyStringValueParser::new(), allow_hyphen_values = true)]
    ilasp_args: Vec<String>, // 直接接受完整参数，允许带连字符
}

impl Cli {
    fn run_ilasp(&self, outpath: &PathBuf, stat: Arc<Mutex<Stat>>) -> anyhow::Result<Duration> {
        let ilasp = self.ilasp.clone();
        println!("Running ILASP... ");

        // 调试：打印原始 ilasp_args
        // eprintln!("Debug: ILASP args: {:?}", self.ilasp_args);

        // 验证参数
        let valid_args = vec!["-na", "-ml=2", "--ml=2", "-v", "--quiet", "--version=1", "--version=2", "--version=2i", "--version=3", "--version=4"];
        let mut has_version = false;
        for arg in &self.ilasp_args {
            if arg.starts_with("--version=") || arg == "-v" {
                has_version = true;
            }
            if !valid_args.contains(&arg.as_str()) && !arg.starts_with("-ml=") && !arg.starts_with("--ml=") {
                eprintln!("Warning: ILASP argument '{}' may be invalid. Check ILASP --help.", arg);
            }
        }
        if !has_version {
            eprintln!("Warning: No ILASP version specified. ILASP requires --version=[1|2|2i|3|4].");
        }

        // 启动 ILASP 子进程
        let mut sys = System::new();
        sys.refresh_processes(ProcessesToUpdate::All, true);

        let mut cmd = Command::new(&ilasp);
        // 直接添加用户输入的参数
        for arg in &self.ilasp_args {
            cmd.arg(arg.trim());
        }
        cmd.arg(outpath);
        // eprintln!("Debug: ILASP command: {:?}", cmd); // 调试：打印完整命令

        let mut child: Child = cmd.spawn()?;
        let pid = Pid::from(child.id() as usize);

        // 测量 CPU 时间和内存
        let start_time = std::time::Instant::now();
        let mut max_memory = 0;

        // 轮询子进程，实时更新内存
        while child.try_wait()?.is_none() {
            sys.refresh_processes(ProcessesToUpdate::Some(&[pid]), true);
            if let Some(process) = sys.process(pid) {
                max_memory = max_memory.max(process.memory());
            }
            std::thread::sleep(std::time::Duration::from_millis(100));
        }

        // 等待子进程结束并获取输出
        let output = child.wait_with_output()?;
        let elapsed_time = start_time.elapsed();

        // 解析 ILASP 输出中的 Total 时间
        let stderr = String::from_utf8_lossy(&output.stderr);
        let ilasp_cpu_time = stderr
            .lines()
            .find(|line| line.contains("Total"))
            .and_then(|line| {
                line.split(':')
                    .last()
                    .and_then(|s| s.trim().strip_suffix('s').and_then(|s| s.trim().parse::<f64>().ok()))
                    .map(|t| std::time::Duration::from_secs_f64(t))
            })
            .unwrap_or(elapsed_time);

        // 更新 Stat
        {
            let mut stat = stat.lock().unwrap();
            stat.record_ilasp_cpu_time(ilasp_cpu_time);
            stat.record_ilasp_memory(max_memory);
        }

        if output.status.success() {
            let stdout = String::from_utf8_lossy(&output.stdout);
            println!("{}", stdout);
            match &self.ilasp_out {
                Some(path) => {
                    let mut file = File::create(path)?;
                    file.write_all(stdout.as_bytes())?;
                }
                None => {}
            }
        } else {
            eprintln!("{}", stderr);
            return Err(anyhow::anyhow!(
                "ilasp execute failed {:?}", output.status.code()
            ));
        }

        Ok(ilasp_cpu_time)
    }

    fn output_las<T: Display, R: Display>(
        &self,
        iltask: &ILTask<T, R>,
        temp_file: &mut NamedTempFile,
    ) -> anyhow::Result<Option<PathBuf>> {
        let program = match &self.template {
            Some(p) => {
                let file = File::open(p)
                    .map_err(|e| anyhow::anyhow!("open template file failed: {}", e))?;
                let mut tpl = String::new();
                BufReader::new(file)
                    .read_to_string(&mut tpl)
                    .map_err(|e| anyhow::anyhow!("read template file failed: {}", e))?;
                iltask.to_progam_with_template(&tpl)?
            }
            None => iltask.to_progam()?,
        };
        match self.output.as_ref() {
            Some(path) => {
                BufWriter::new(File::create(path)?).write(program.as_bytes())?;
                Ok(self.output.clone())
            }
            None => {
                if self.run {
                    temp_file.write(program.as_bytes())?;
                    temp_file.flush()?;
                    let temp_path = temp_file.path();
                    Ok(Some(temp_path.to_path_buf()))
                } else {
                    BufWriter::new(stdout()).write(program.as_bytes())?;
                    Ok(None)
                }
            }
        }
    }

    pub fn run(&self, stat: Arc<Mutex<Stat>>) -> anyhow::Result<()> {
        let cloned_stat = stat.clone();
        let mut temp_file = NamedTempFile::new()?;
        let tmpfile = Arc::new(temp_file.path().to_path_buf());

        ctrlc::set_handler(move || {
            let _ = ::std::fs::remove_file(tmpfile.as_path());
            if let Ok(mut stat) = cloned_stat.lock() {
                stat.finish();
                println!("\n\n===== Statistics ====");
                println!("{}", stat);
            }
            println!("Ctrl-C pressed. Exiting...");

            std::process::exit(-1);
        })?;

        let mut buf = String::new();
        match self.input.as_ref() {
            Some(p) => {
                let f = File::open(p)?;
                BufReader::new(f).read_to_string(&mut buf)?;
            }
            None => {
                BufReader::new(stdin()).read_to_string(&mut buf)?;
            }
        }
        println!("Parsing...");
        let mut c = ilnlp::parser::parse_task(&buf)?;
        stat.lock().unwrap().parse();
        c.check_compatibility()?;
        println!("Converting...");
        let iltask = c.ilas(stat.clone())?;
        stat.lock().unwrap().convert();
        let outpath = self.output_las(&iltask, &mut temp_file)?;
        stat.lock().unwrap().output();
        if self.run {
            let outpath = outpath.unwrap();
            let solve_time = self.run_ilasp(&outpath, stat.clone())?;
            stat.lock().unwrap().solve(solve_time);
        }

        Ok(())
    }
}

fn main() {
    let cli = Cli::parse();
    let stat = Arc::new(Mutex::new(Stat::new()));
    let result = cli.run(stat.clone());

    stat.lock().unwrap().finish();
    if let Err(e) = result {
        eprintln!("{}", e);
    }
    println!("\n\n===== Statistics ====");
    println!("{}", stat.lock().unwrap());
}

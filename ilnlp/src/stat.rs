/// Some functions and struct for statistics 


use std::{
    fmt::Display,
    time::{Duration, Instant},
};
use cpu_time::ProcessTime;
use sysinfo::{Pid, ProcessesToUpdate, System};

struct TimeRecorder(ProcessTime, Instant);

#[derive(Debug, Default)]
struct TimeRecord(Option<(Duration, Duration)>);

impl Default for TimeRecorder {
    fn default() -> Self {
        TimeRecorder(ProcessTime::now(), Instant::now())
    }
}

impl TimeRecord {
    fn print_cpu_time(&self, f: &mut std::fmt::Formatter<'_>, title: &str) -> std::fmt::Result {
        if let Some(t) = self.0 {
            writeln!(f, "{}{:?}", title, t.0)?;
        }
        Ok(())
    }
}

impl TimeRecorder {
    fn elapsed(&self) -> (Duration, Duration) {
        (self.0.elapsed(), self.1.elapsed())
    }
}

#[derive(Default)]
pub struct Stat {
    total_recoder: TimeRecorder,
    last_recoder: TimeRecorder,
    parse_time: TimeRecord,
    convert_time: TimeRecord,
    solve_time: TimeRecord,
    output_time: TimeRecord,
    total_time: TimeRecord,
    ilasp_cpu_time: TimeRecord,
    ilasp_memory: Option<u64>,
    universe_size: Option<usize>,
    unique_predicates: Option<usize>,
}

unsafe impl Send for Stat {}
unsafe impl Sync for Stat {}

impl Display for Stat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        self.parse_time.print_cpu_time(f, "Parse time: ")?;
        self.convert_time.print_cpu_time(f, "Convert time: ")?;
        self.solve_time.print_cpu_time(f, "Solve time: ")?;
        self.output_time.print_cpu_time(f, "Output time: ")?;
        self.total_time.print_cpu_time(f, "Total time: ")?;
        get_memory().map(|v| {
            println!("Memory:  {}", human_bytes::human_bytes(v as f64));
        });
        self.ilasp_cpu_time.print_cpu_time(f, "ILASP CPU time: ")?;
        if let Some(memory) = self.ilasp_memory {
            writeln!(f, "ILASP Memory: {}", human_bytes::human_bytes(memory as f64))?;
        } else {
            writeln!(f, "ILASP Memory: Not available")?;
        }
        if let Some(size) = self.universe_size {
            writeln!(f, "Universe Size: {} literals", size)?;
        } else {
            writeln!(f, "Universe Size: Not available")?;
        }
        if let Some(count) = self.unique_predicates {
            writeln!(f, "Unique Predicates: {}", count)?;
        } else {
            writeln!(f, "Unique Predicates: Not available")?;
        }
        Ok(())
    }
}

macro_rules! record {
    ($stc:ident, $name:ident) => {
        $stc.$name = TimeRecord(Some($stc.last_recoder.elapsed()));
        $stc.last_recoder = TimeRecorder::default();
    };
}

impl Stat {
    pub fn new() -> Self {
        Stat::default()
    }

    pub fn parse(&mut self) {
        record!(self, parse_time);
    }
    pub fn convert(&mut self) {
        record!(self, convert_time);
    }
    pub fn solve(&mut self, solve_time: Duration) {
        self.solve_time = TimeRecord(Some((solve_time, Duration::default())));
        self.last_recoder = TimeRecorder::default();
    }
    pub fn output(&mut self) {
        record!(self, output_time);
    }
    pub fn finish(&mut self) {
        // 显式累加各阶段时间
        let total = self.parse_time.0.unwrap_or_default().0
            + self.convert_time.0.unwrap_or_default().0
            + self.solve_time.0.unwrap_or_default().0
            + self.output_time.0.unwrap_or_default().0;
        self.total_time = TimeRecord(Some((total, Duration::default())));
    }

    pub fn record_ilasp_cpu_time(&mut self, cpu_time: Duration) {
        self.ilasp_cpu_time = TimeRecord(Some((cpu_time, Duration::default())));
    }

    pub fn record_ilasp_memory(&mut self, memory: u64) {
        self.ilasp_memory = Some(memory);
    }

    pub fn record_universe_stats(&mut self, size: usize, unique_predicates: usize) {
        self.universe_size = Some(size);
        self.unique_predicates = Some(unique_predicates);
    }
}

pub fn get_memory() -> Option<u64> {
    let pid = Pid::from(std::process::id() as usize);
    let mut sys = System::new();
    sys.refresh_processes(ProcessesToUpdate::All, true);
    sys.process(pid).map(|process| process.memory())
}
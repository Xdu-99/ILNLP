Random_Example.zip is a zipped file of tasks and results of Hamilton circuit and graph coloring problem in the experiments.

#install rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#build
```
cargo build

cargo build --release
```

#Change the permissions of ILASP
```
chmod +x ./ILASP
```

#run
```
./target/release/ilnlp -r --ilasp-out="PATH_RESULT_FILE" --output="PATH_LAS_FILE" --background="PATH_Background_FILE" --template="PATH_DECLARATION_FILE" --example="PATH_TASK_FILE" --ilasp ./ILASP --ilasp-args --version=4 
```
#the help of ilnlp
```
 ./target/release/ilnlp  -h
```
```
Usage: ilnlp [OPTIONS] --example <EXAMPLE>

Options:
  -e, --example <EXAMPLE>        Example file
  -o, --output <OUTPUT>          Output file for generated ILASP-compatible input file Defaults to stdout; if empty and running ILASP, do not output
      --background <BACKGROUND>  Background file
      --ilasp <ILASP>            ILASP executable path, defaults to "ILASP" [default: ILASP]
      --template <TEMPLATE>      Template file for covert to ILASP-compatible input file
      --ilasp-out <ILASP_OUT>    Output file for ILASP execution results, defaults to stdout
  -r, --run                      Run ILASP solver, defaults to false
      --ilasp-args <ILASP_ARGS>  pass to ILASP
  -h, --help                     Print help
```

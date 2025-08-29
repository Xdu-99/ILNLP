Random_Example.zip is a zipped file of tasks and results of Hamilton circuit and graph coloring problem in the experiments.
ILNLP.zip is a zipped file of source code. After decompression, enter the path "ilnlp" and follow the following steps.

#install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#build
cargo build
cargo build --release

#Change the permissions of ILASP

chmod +x ./ILASP

#run
./target/release/ilnlp -r --output PATH_LAS_FILE --template PATH_DECLARATION_FILE --ilasp ./ILASP --ilasp-args --version=4 --ilasp-args -na PATH_TASK_FILE

#the help of ilnlp
 ./target/release/ilnlp  -h

Usage: ilnlp [OPTIONS] [INPUT]

Arguments:
  [INPUT]  

Options:
  -o, --output <OUTPUT>          
      --ilasp <ILASP>            [default: ILASP]
      --template <TEMPLATE>      
      --ilasp-out <ILASP_OUT>    
  -r, --run                      
      --ilasp-args <ILASP_ARGS>  
  -h, --help                     Print help

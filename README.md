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
```

#! /bin/bash
ILNLP=../target/release/ilnlp
ILASP=../ILASP
ne=$1 # number of examples [5, 10, 30]
nr=$2 # number of rules to learn, 
mb=$3 # the maximal length of body rules
i=1
while (( i<=10 ))
  do
    ulimit -t 1800 -v 80960000 # set the cpu time in 1800 seconds and virtual memory in 8G
    $ILNLP -r --ilasp-out="./$nr/ilasp-results/hc-$ne-$i.txt"  --output="./$nr/results/hc-$ne-$i.txt" --background="./Background-Knowledge/hc-$nr.lp" --example="./examples/hc-$ne-$i.las" --template="./mode-bias/Hamilton.tpl" --ilasp $ILASP --ilasp-args --version=4 --ilasp-args -ml=$mb &> ./$nr/ilnlp-results/hc-$ne-$i.txt
    let i=i+1
 done

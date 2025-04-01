#!/bin/bash

rm -rf tmp.txt

echo " bin/ex1b  N=1"; bin/ex1b  --NumTasks=1  --NumLoops=1 --NumData=1000000 --RndScale=0.0001  > tmp.txt
echo " bin/ex2b  N=1"; bin/ex2b  --NumTasks=1  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b  N=1"; bin/ex3b  --NumTasks=1  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b  N=1"; bin/ex4b  --NumTasks=1  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b  N=1"; bin/lwt1b --NumTasks=1  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b  N=1"; bin/lwt2b --NumTasks=1  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

echo " bin/ex1b  N=2"; bin/ex1b  --NumTasks=2  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex2b  N=2"; bin/ex2b  --NumTasks=2  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b  N=2"; bin/ex3b  --NumTasks=2  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b  N=2"; bin/ex4b  --NumTasks=2  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b  N=2"; bin/lwt1b --NumTasks=2  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b  N=2"; bin/lwt2b --NumTasks=2  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

echo " bin/ex1b  N=4"; bin/ex1b  --NumTasks=4  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex2b  N=4"; bin/ex2b  --NumTasks=4  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b  N=4"; bin/ex3b  --NumTasks=4  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b  N=4"; bin/ex4b  --NumTasks=4  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b  N=4"; bin/lwt1b --NumTasks=4  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b  N=4"; bin/lwt2b --NumTasks=4  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

echo " bin/ex1b  N=8"; bin/ex1b  --NumTasks=8  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex2b  N=8"; bin/ex2b  --NumTasks=8  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b  N=8"; bin/ex3b  --NumTasks=8  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b  N=8"; bin/ex4b  --NumTasks=8  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b  N=8"; bin/lwt1b --NumTasks=8  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b  N=8"; bin/lwt2b --NumTasks=8  --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

echo " bin/ex1b N=16"; bin/ex1b  --NumTasks=16 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex2b N=16"; bin/ex2b  --NumTasks=16 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b N=16"; bin/ex3b  --NumTasks=16 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b N=16"; bin/ex4b  --NumTasks=16 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b N=16"; bin/lwt1b --NumTasks=16 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b N=16"; bin/lwt2b --NumTasks=16 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

echo " bin/ex1b N=32"; bin/ex1b  --NumTasks=32 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex2b N=32"; bin/ex2b  --NumTasks=32 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b N=32"; bin/ex3b  --NumTasks=32 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b N=32"; bin/ex4b  --NumTasks=32 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b N=32"; bin/lwt1b --NumTasks=32 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b N=32"; bin/lwt2b --NumTasks=32 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

echo " bin/ex1b N=64"; bin/ex1b  --NumTasks=64 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex2b N=64"; bin/ex2b  --NumTasks=64 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex3b N=64"; bin/ex3b  --NumTasks=64 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo " bin/ex4b N=64"; bin/ex4b  --NumTasks=64 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt1b N=64"; bin/lwt1b --NumTasks=64 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt
echo "bin/lwt2b N=64"; bin/lwt2b --NumTasks=64 --NumLoops=1 --NumData=1000000 --RndScale=0.0001 >> tmp.txt

if [[ -e benchmark.txt ]]; then
   mv benchmark.txt benchmark.txt.saved
fi

rm -rf benchmark.txt

grep "bin/" tmp.txt > benchmark.txt

#!/usr/bin/bash

# Install wgets to download from github, gcc, and g++ for code

sudo yum groupinstall -y "Development Tools"
sudo yum install -y wget openmpi php php-xml
mkdir /home/centos/benchmark
cd /home/centos/benchmark
wget https://github.com/tw19816/CIUK_Bristol2/archive/main.tar.gz
tar xf main.tar.gz
cd CIUK_Bristol2-main
echo lmao, now we start benchmarking
./run_benchmarks.sh >> ../logfile.txt
echo lmao, now we email the result
python email_sending.py results_

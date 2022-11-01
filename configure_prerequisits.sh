#!/usr/bin/bash

# Install wgets to download from github, gcc, and g++ for code
sudo yum groupinstall -y "Development Tools"
sudo yum install -y wget php php-xml php-json python3
# Create dir for benchmark and download github repo
mkdir /home/centos/benchmark
cd /home/centos/benchmark
wget https://github.com/tw19816/CIUK_Bristol2/archive/main.tar.gz
tar xf main.tar.gz
cd CIUK_Bristol2-main
# Run benchmark script
./run_benchmarks.sh
cd ~
cd /home/centos/benchmark/CIUK_Bristol2-main/
python email_sending.py results_

#!/usr/bin/env bash

# Install wgets to download from github, gcc, and g++ for code
sudo yum groupinstall -y "Development Tools"
sudo yum install -y wget openmpi php php-xml
wget https://github.com/tw19816/CIUK_Bristol2/archive/main.tar.gz
tar xf main.tar.gz
cd CIUK_Bristol2
./run_benchmarks.sh >> logfile.txt
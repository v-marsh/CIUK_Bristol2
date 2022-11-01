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
# Create OpenMPI and add to path
cd OpenMP
tar xf openmpi-4.1.4.tar.gz
mv openmpi-4.1.4/* . && rmdir openmpi-4.1.4
./configure --prefix=/users/alces-cluster/openmpi --with-slurm --with-psm2
make
make install
export PATH="$OpenMPI:$PATH"
export LD_LIBRARY_PATH="$:$LD_LIBRARY_PATH"
cd ..
# Run benchmark script
./run_benchmarks.sh
cd ~
cd /home/centos/benchmark/CIUK_Bristol2-main/
python email_sending.py results_

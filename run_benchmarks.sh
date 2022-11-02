#!/usr/bin/env bash

# Configure platform hardware
num_nodes=1
num_cpus=1  
num_cores_per_cpu=2
num_cores=$(nproc --all)
# configure test parameters
num_iterations=1
num_iterations_2=2
matmul_arr_size1=3000
matmul_arr_size2=10000

# Create results directory
mkdir ./results_
output=./results_

# Memory bandwidth test for one node
gcc ./stream/stream.c -o ./stream/stream -fopenmp
sudo chmod 777 ./stream/stream
let num_threads=$num_cpus*$num_cores_per_cpu
export OMP_NUM_THREADS=$num_threads
for ((iter=0; iter < $num_iterations; iter++))
do
    ./stream/stream >> $output/streamdata.txt
done

# IO performance
make -C ./iozone/src/ linux-AMD64
./iozone/src/iozone -a -g 10G -f testfile.txt -O >> $output/IO.txt



# Single core integer and floating point operations
sudo chmod 777 single_core multi_core
g++ ./single_core/matmul.cpp -o ./single_core/matmul
sudo touch $output/single_core_data.txt 
sudo chmod 777 $output/single_core_data.txt
for ((iter=0; iter < $num_iterations_2; iter++))
do
    ./single_core/matmul $matmul_arr_size1 >> $output/single_core_data.txt
done

# Multicore floating point operations
g++ ./multi_core/matmul_parallel.cpp -o ./multi_core/matmul_parallel -fopenmp
sudo touch $output/multi_core_data.txt 
sudo chmod 777 $output/multi_core_data.txt
for ((iter=0; iter < $num_iterations_2; iter++))
do
    ./multi_core/matmul_parallel $matmul_arr_size2 $num_cores >> $output/multi_core_data.txt
done

# phoronix test suite
#./phoronix-test-suite/install.sh ./
#./phoronix-test-suite/bin/phoronix-test-suite benchmark intel-mpi >> $output/interconnect_ph.txt






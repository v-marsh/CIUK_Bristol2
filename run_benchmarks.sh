#!/usr/bin/env bash

# Configure platform hardware
num_nodes=1
num_cpus=1
num_cores_per_cpu=1
# configure test parameters
num_iterations=1
matmul_arr_size=1

# Create results directory
mkdir ./results_$1
output=./results_$1


# Memory bandwidth test for one node
gcc ./stream/stream.c -o ./stream/stream -fopenmp
export OMP_NUM_THREADS=$num_cpus*$num_cores_per_cpu
for ((iter=0; iter < $num_iterations; iter++))
do
    ./stream/stream >> $output/streamdata.txt
done

# Single core integer and floating point operations
g++ ./single_core/matmul.cpp -o ./single_core/matmul
for ((iter=0; iter < $num_iterations; iter++))
do
    ./single_core/matmul $matmul_arr_size >> $output/single_core_data.txt
done

# IO performance
make -C ./iozone/src/ linux-AMD64



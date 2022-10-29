#!/usr/bin/env bash

# Configure platform hardware
set num_nodes=1
set num_cpus=1
set num_cores_per_cpu=1
# configure test parameters
set num_iterations=1
set matmul_arr_size=1


# Memory bandwidth test for one node
gcc ./stream/stream.c -o ./stream/steam -fopenmp
export OMP_NUM_THREADS=$num_cpus*$num_cores_per_cpu
./stream/stream > results/streamdata.txt

# Single core integer and floating point operations
g++ ./single_core/matmul.cpp -o ./single_core/matmul
./single_core/matmul $matmul_arr_size > results/single_core_data.txt
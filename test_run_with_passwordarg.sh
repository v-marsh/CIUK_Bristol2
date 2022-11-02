#!/usr/bin/env bash

# Configure platform hardware
num_nodes=1
num_cpus=1  
num_cores_per_cpu=2
num_cores=$(nproc --all)
# configure test parameters
num_iterations=1
num_iterations_2=2
matmul_arr_size1=10
matmul_arr_size2=10

# Create results directory
mkdir ./results_
output=./results_

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

#!/usr/bin/env bash

# Configure platform hardware
num_nodes=1
num_cpus=1
num_cores_per_cpu=1
# configure test parameters
num_iterations=1
matmul_arr_size=10000

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

# Multicore floating point operations
g++ ./multi_core/matmul_parallel.cpp -o ./multi_core/matmul_parallel -fopenmp
for ((iter=0; iter < $num_iterations; iter++))
do
    ./multi_core/matmul_parallel $matmul_arr_size $num_cores_per_cpu*$num_cpus >> $output/multi_core_data.txt
done

# IO performance
make -C ./iozone/src/ linux-AMD64
./iozone/src/iozone -a -g 10G -f testfile.txt -O >> $output/IO.txt

# Interconnect performance
make -C ./mpi_bench/ IBM-MPI1
mpirun -np2 IBM-MPI1 >> $output/interconnect.txt

# phoronix test suite
./phoronix-test-suite/install.sh ./
./phoronix-test-suite/bin/phoronix-test-suite benchmark intel-mpi >> $output/interconnect_ph.txt






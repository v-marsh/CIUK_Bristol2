# Run IMB for communications benchmark
cd mpi-benchmarks/
make IMB-MPI1
cd ../
mpiirun -n 2 IMB-MPI  
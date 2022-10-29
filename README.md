# CUIK_Bristol2

The challenge was approached to maximise our efficiency in collecting data from each system. We considered running tests manually to benchmark systems however decided running all tests from a bash script future proofed our work. This would allow us to test all benchmarks on cheap systems, and then run tests quickly on resource intensive systems. It would also allow for better automation for the final challenge.

## Challenge 1

**Single-core integer and FP comparison:** 
To benchmark single core integer calculations, a custom matrix multiplication program was created. It takes N to create a NxN matrix individually calculating elements. Outputing the time it takes to calculate the new multiplied matrix. From this FLOPS can be calculated. The same matrix multiplication code is then converted for floating point integers.

**Multi-core single-node comparison:** Multi-core benchmarking is done in a similar fashion using the FP matrix multiplication code. This was parallelised using OpenMP pushing operations through the maximum amount of threads available to us. Again this code outputs a time for completion which can then be used to calculate FLOPS

**Memory bandwidth** Stream benchmark was used to test for memory bandwidth

**Interconnect latency** We use a Ping Pong code to test interconnect latency

**Interconnect bandwidth** send and recieve files, timed

**I/O disk performance** We run the IoZone benchmark specifying we only want to consider read/reread and write/rewrite scores ouputed as IOPS. This benchmark works with 2 Gb data packets.

**Filesystem transaction performance** ...

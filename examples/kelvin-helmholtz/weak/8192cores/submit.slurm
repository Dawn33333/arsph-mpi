#!/bin/bash
#SBATCH --job-name=8192coresParallelEfficiency
#SBATCH -N 128
#SBATCH -p xahcnormal
#SBATCH --ntasks-per-node=64
#SBATCH --constraint="64core"
#SBATCH --exclusive

# load the environment
module purge      #clean the environment
module load compiler/intel/2017.5.239 mpi/intelmpi/2017.4.239


mpirun -np 8192 ./ARSPH <<EOF
208



0


EOF



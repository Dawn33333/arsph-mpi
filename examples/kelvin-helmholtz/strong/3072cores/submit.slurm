#!/bin/bash
#SBATCH --job-name=3072coresParallelEfficiency
#SBATCH -N 48
#SBATCH -p xahcnormal
#SBATCH --ntasks-per-node=64
#SBATCH --constraint="64core"
#SBATCH --exclusive

# load the environment
module purge      #clean the environment
module load compiler/intel/2017.5.239 mpi/intelmpi/2017.4.239


mpirun -np 3072 ./ARSPH <<EOF
208



0


EOF



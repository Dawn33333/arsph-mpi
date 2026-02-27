#!/bin/bash
#SBATCH --job-name=128coresKelvinHelmholtz
#SBATCH -N 2
#SBATCH -p xahcnormal
#SBATCH --ntasks-per-node=64
#SBATCH --constraint="64core"
#SBATCH --exclusive

# load the environment
module purge      #clean the environment
module load compiler/intel/2017.5.239 mpi/intelmpi/2017.4.239


mpirun -np 128 ./ARSPH <<EOF
36481



0


EOF



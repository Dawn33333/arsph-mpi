# ARSPH-MPI

Massive MPI-parallel adaptive-resolution SPH solver for large-scale multiphase flow simulations.  
This repository provides the **binary reproducibility package** associated with the Computer Physics Communications manuscript:

**A Massive MPI Parallel Adaptive Resolution SPH Method for Large-Scale Multiphase Flow Simulations**

---

## Purpose of this repository

This repository provides executable programs and run scripts that allow readers and reviewers to reproduce:

- the 3D Kelvin–Helmholtz instability problem
- strong scaling performance test
- weak scaling performance test

reported in the manuscript.

The implementation is distributed **in binary form only**.  
All necessary input data and test configurations are embedded in each executable.

---

## Software availability statement

The full source code cannot be publicly released due to funding agreement restrictions and intellectual property constraints associated with the supporting research grants.
To ensure reproducibility and verification:

- Executable binaries are provided
- All input data are compiled into the executables
- Run scripts are provided for MPI and SLURM environments
- Test cases correspond directly to those in the manuscript
- Key algorithms are fully described in the paper (with pseudocode)

These materials enable independent reproduction of the numerical results and performance measurements.

---

## Requirements

- Linux x86_64
- MPI implementation (any of the following):
  - OpenMPI
  - MPICH
  - Intel MPI
- SLURM is required only for batch submission scripts

The code is MPI-based and does not depend on a specific MPI vendor.

---

## Repository structure

This repository contains executable binaries and run scripts for the
Kelvin–Helmholtz instability problem used in the manuscript.

The files are organized as follows:

- `examples/kelvin-helmholtz/strong/`
  Contains executables for strong scaling tests with a fixed problem size.
  Separate subdirectories are provided for different MPI core counts
  (e.g., 128, 256, 256, 512, 1024, 2048, 3072, 4096 cores).

- `examples/kelvin-helmholtz/weak/`
  Contains executables for weak scaling tests.  
  Each executable has the problem size embedded internally and corresponds
  to a specific MPI core count.

Within each scaling directory, the following files are provided:

- `ARSPH` — self-contained executable binary  
- `run.sh` — MPI execution script  
- `submit.slurm` — example SLURM batch submission script  

All executables include the required input data internally and do not
require external configuration files.

---

## Running the executables

To reproduce the results, follow the steps below.

### Step 1. Enter the desired working directory

For example, for a 128-core strong-scaling test:

```bash
cd examples/kelvin-helmholtz/strong/128cores
```

---

### Step 2. Grant execution permission

```bash
chmod +x ARSPH run.sh
```

---

### Step 3. Create required output directories

The program writes output data to the following directories.  
Create them before execution:

```bash
mkdir parallelio data
```

---

### Step 4. Running the program

#### 4.1 Running interactively (MPI)

To run the program interactively using MPI:

```bash
./run.sh
```

The script internally executes:

```bash
mpirun -np <N> ./ARSPH <<EOF
208
0
EOF
```

where `<N>` corresponds to the MPI core count associated with the current directory  
(e.g., 64cores, 128cores, 256cores, etc.).

Each scaling directory contains a `run.sh` script configured for its specific MPI core count.

---

#### 4.2 Running via SLURM (HPC batch systems)

On SLURM-based HPC systems, submit the job using:

```bash
sbatch submit.slurm
```

The `submit.slurm` script specifies:

- number of nodes  
- MPI ranks per node  
- total core count  
- partition/queue  
- required environment modules

Users may adjust SLURM resource parameters according to their local cluster configuration.

---

### 5. Output

During execution, the program prints:

- runtime statistics  
- solver progress information  

Performance results reported in the manuscript correspond to the total wall-clock time printed during execution.

Minor floating-point variations across different systems are expected.

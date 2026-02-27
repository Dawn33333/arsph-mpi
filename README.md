# ARSPH-MPI

Massive MPI-parallel adaptive-resolution SPH solver for large-scale multiphase flow simulations.  
This repository provides the **binary reproducibility package** associated with the Computer Physics Communications manuscript:

**A Massive MPI Parallel Adaptive Resolution SPH Method for Large-Scale Multiphase Flow Simulations**

---

## Purpose of this repository

This repository provides executable programs and run scripts that allow readers and reviewers to reproduce:

- the Kelvin-Helmholtz instability problem  
- strong scaling test  
- weak scaling test  

reported in the manuscript.

The implementation is distributed **in binary form only**.  
All necessary input data and test configurations are embedded in each executable.

---

## Software availability statement

The full source code cannot be publicly released due to funding agreement restrictions and intellectual property constraints associated with the supporting research grants.

To ensure reproducibility and verification:

- Executable binaries are provided  
- All required input data are embedded in the executables  
- Run scripts are provided for MPI and SLURM environments  
- Test cases correspond directly to those in the manuscript  
- Key algorithms are fully described in the paper (including pseudocode)

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
Kelvin-Helmholtz instability problem used in the manuscript.

The files are organized as follows:

- `examples/kelvin-helmholtz/full-simulation/`  
  Contains the complete physical simulation of the Kelvin-Helmholtz instability
  problem from initialization to the final simulation time.  
  This run reproduces the full time evolution presented in the manuscript.

- `examples/kelvin-helmholtz/strong/`  
  Contains executables for the strong scaling test with a fixed problem size.  
  Separate subdirectories are provided for different MPI core counts  
  (e.g., 128, 256, 512, 1024, 2048, 3072, 4096 cores).

- `examples/kelvin-helmholtz/weak/`  
  Contains executables for the weak scaling test.  
  Each executable has the problem size embedded internally and corresponds  
  to a specific MPI core count.

Within each scaling directory, the following files are provided:

- `ARSPH` — executable binary  
- `run.sh` — MPI execution script  
- `submit.slurm` — example SLURM batch submission script  

All executables include the required input data internally and do not
require external configuration files.

---

## Running the executables

To reproduce the results, follow the steps below.

### Step 1. Enter the desired working directory

For example, for a 128-core strong scaling test:

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

Create output directories before execution:

```bash
mkdir parallelio data
```

---

### Step 4. Running the program

#### 4.1 Running interactively (MPI)

```bash
./run.sh
```

The script internally executes:

```bash
#!/bin/bash
mpirun -np <N> ./ARSPH <<EOF
208
0
EOF
```

where `<N>` corresponds to the MPI core count associated with the current directory.

---

#### 4.2 Running via SLURM (HPC batch systems)

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

## Output

During execution, the program writes simulation particle data to the
`parallelio/` directory.

This directory must be created before execution and will contain the
output fields generated during the simulation.

Runtime information and solver diagnostics are printed to the terminal.
The performance measurements reported in the manuscript correspond to
the total wall-clock time printed during execution.

Minor floating-point differences across systems are expected in
parallel MPI runs.

---

## Reproducibility notes

- All input data are embedded in the executable binaries  
- No external configuration files are required  
- Each executable corresponds to a specific configuration  
- The Kelvin-Helmholtz instability problem provided here is identical to the one
  used in the manuscript  
- Strong scaling test uses a fixed global problem size  
- Weak scaling test uses problem sizes that scale with MPI core count  

These executables are provided solely for verification of the results
reported in the associated publication.


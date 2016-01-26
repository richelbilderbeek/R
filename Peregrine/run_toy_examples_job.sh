#!/bin/bash
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=run_toy_examples
#SBATCH --mail-type=BEGIN,END
module load R
./run_toy_examples.sh
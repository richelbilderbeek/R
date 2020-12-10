#!/bin/bash
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=analyse_toy_examples
#SBATCH --mail-type=BEGIN,END
#SBATCH --output=analyse_toy_examples_job.log
module load R
./analyse_toy_examples.sh
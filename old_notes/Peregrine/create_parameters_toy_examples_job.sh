#!/bin/bash
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=create_parameters_toy_example
#SBATCH --mail-type=BEGIN,END
#SBATCH --output=create_parameters_toy_examples_job.log
module load R
./create_parameters_toy_examples.sh
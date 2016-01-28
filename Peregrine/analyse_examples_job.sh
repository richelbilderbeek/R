#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=analyse_examples
#SBATCH --mail-type=BEGIN,END
#SBATCH --output=analyse_examples_job.log
module load R
./analyse_examples.sh
#!/bin/bash
#SBATCH --time=0-00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1000
#SBATCH --job-name=test_job_1
#SBATCH --mail-type=BEGIN,END
#SBATCH --partition=short
module load R
Rscript process_parameter_files.R

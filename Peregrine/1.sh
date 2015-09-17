#!/bin/bash
#SBATCH --time=0-00:00:01
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1
#SBATCH --job-name=test_job_1
#SBATCH --mail-type=BEGIN,END
#SBATCH --partition=short
module load R/3.1.2-goolfc-2.7.11-default
Rscript script.R

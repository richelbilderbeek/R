#!/bin/bash
#SBATCH --time=0-00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=10000
#SBATCH --job-name=test_job_2
#SBATCH --mail-type=BEGIN,END
#SBATCH --partition=short
module load R/3.2.1-goolfc-2.7.11-default-X11
Rscript run.R
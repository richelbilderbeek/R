#!/bin/bash
#SBATCH --time=16:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=article
#SBATCH --mail-type=BEGIN,END
module load R Beast
Rscript do_simulation.R $1
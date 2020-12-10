#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100000
#SBATCH --job-name=create_parameters_article
#SBATCH --mail-type=BEGIN,END
#SBATCH --output=create_parameters_article_job.log
module load R
./create_parameters_article.sh
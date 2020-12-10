#!/bin/bash
# Call with e.g. 'sbatch ./sbatch_me do_simulation.R example1.RDa'
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --ntasks=4
#SBATCH --mem=10G
#SBATCH --job-name=article
#SBATCH --mail-type=BEGIN,END
module load R Beast
Rscript $1 $2
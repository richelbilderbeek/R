#!/bin/bash
for filename in `ls article_*.RDa`
do
  sbatch ./sbatch_me.sh do_simulation.R $filename
done
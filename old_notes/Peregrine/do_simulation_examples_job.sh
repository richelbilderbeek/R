#!/bin/bash
for filename in `ls example_*.RDa`
do
  sbatch ./sbatch_me.sh $filename
done
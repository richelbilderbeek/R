#!/bin/bash
for filename in `ls toy_example_*.RDa`
do
  sbatch ./sbatch_me.sh $filename
done
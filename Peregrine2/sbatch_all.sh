#!/bin/bash
for filename in `ls *.RDa`
do
  sbatch ./sbatch_me.sh $filename
done
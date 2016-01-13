#!/bin/bash
for filename in `ls *.RDa`
do
  ./sbatch_me.sh $filename
done
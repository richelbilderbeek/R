#!/bin/bash
for filename in `ls example_*.RDa`
do
  Rscript do_simulation.R $filename
done
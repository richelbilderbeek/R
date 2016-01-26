#!/bin/bash
for filename in `ls toy_example_*.RDa`
do
  Rscript do_simulation.R $filename
done
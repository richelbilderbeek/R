#!/bin/bash
for filename in `ls example_*.RDa`
do
  Rscript check_parameter_file.R $filename
done
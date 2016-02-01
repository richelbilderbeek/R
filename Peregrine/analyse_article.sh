#!/bin/bash

# Individual file
for filename in `ls article_*.RDa`
do
  Rscript analyse.R $filename
done

# Compare BEAST2 runs: how similar are two runs?
Rscript plot_beast_repeatabilities.R

# Compare alignments: how similar are two alignments?
Rscript plot_alignment_repeatabilities.R
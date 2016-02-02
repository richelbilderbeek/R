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

# Compare species trees: how similar are species trees?
Rscript plot_species_tree_repeatabilities.R

# Compare species trees: count the number of paraphylies
Rscript plot_paraphyly_count.R
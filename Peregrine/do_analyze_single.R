source("~/GitHubs/R/Peregrine/plot_gene_tree.R")
source("~/GitHubs/R/Peregrine/plot_species_tree_with_outgroup.R")
source("~/GitHubs/R/Peregrine/plot_species_tree_with_outgroup_nltt.R")
source("~/GitHubs/R/Peregrine/do_analyze_alignments.R")
source("~/GitHubs/R/Peregrine/do_analyze_posterior_average_nltts.R")
source("~/GitHubs/R/Peregrine/do_analyze_posterior_samples.R")
source("~/GitHubs/R/Peregrine/do_analyze_posterior_sample_nltts.R")
source("~/GitHubs/R/Peregrine/do_analyze_both_nltts.R")
source("~/GitHubs/R/Peregrine/do_analyze_nltts_stats.R")
source("~/GitHubs/R/Peregrine/do_analyze_posterior_average_nltt.R")

do_analyze_single <- function(filename) {
  if (!file.exists(filename)) {
    print(paste(filename,": not found"))
    stop()
  }
  plot_gene_tree(filename)  
  plot_species_tree_with_outgroup(filename)
  plot_species_tree_with_outgroup_nltt(filename)
  do_analyze_alignments(filename)
  do_analyze_posterior_average_nltts(filename)
  do_analyze_posterior_samples(filename)
  do_analyze_posterior_sample_nltts(filename)
  do_analyze_both_nltts(filename)
  do_analyze_nltts_stats(filename)
  do_analyze_posterior_average_nltt(filename)
}

setwd("~/GitHubs/R/Peregrine")
do_analyze_single("example_1.RDa")

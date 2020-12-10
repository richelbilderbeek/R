source("~/GitHubs/R/Peregrine/plot_gene_tree.R")
source("~/GitHubs/R/Peregrine/plot_species_tree_with_outgroup.R")
source("~/GitHubs/R/Peregrine/plot_species_tree_with_outgroup_nltt.R")
source("~/GitHubs/R/Peregrine/plot_alignments.R")
source("~/GitHubs/R/Peregrine/plot_posterior_average_nltts.R")
source("~/GitHubs/R/Peregrine/plot_posterior_samples.R")
source("~/GitHubs/R/Peregrine/plot_posterior_sample_nltts.R")
source("~/GitHubs/R/Peregrine/plot_posterior_nltt_stats_histogram.R")

analyse_single <- function(filename) {
  if (!file.exists(filename)) {
    print(paste(filename,": not found"))
    stop()
  }
  plot_gene_tree(filename)  
  plot_species_tree_with_outgroup(filename)
  plot_species_tree_with_outgroup_nltt(filename)
  plot_alignments(filename)
  plot_posterior_average_nltts(filename)
  plot_posterior_samples(filename)
  plot_posterior_sample_nltts(filename)
  plot_posterior_nltt_stats_histogram(filename)
}
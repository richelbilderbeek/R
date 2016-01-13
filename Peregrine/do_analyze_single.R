source("read_libraries.R")

do_analyze_single <- function(filename) {
  if (!file.exists(filename)) {
    print(paste(filename,": not found"))
    stop()
  }
  do_analyze_single_gene_tree(filename)  
  do_analyze_single_species_tree_with_outgroup(filename)
  do_analyze_single_species_tree_with_outgroup_nltt(filename)
  do_analyze_alignments(filename)
  do_analyze_posterior_average_nltts(filename)
  do_analyze_posterior_samples(filename)
  do_analyze_posterior_sample_nltts(filename)
  do_analyze_both_nltts(filename)
  do_analyze_nltts_stats(filename)
  do_analyze_posterior_average_nltt(filename)
}
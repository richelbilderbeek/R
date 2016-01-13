do_analyze_single_species_tree_with_outgroup_nltt <- function(filename) {
  assert(file.exists(filename))
  base_filename <- get_base_filename(filename)
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  for (i in seq(1,n_species_trees_samples)) {
    png(paste(base_filename,"_species_tree_with_outgroup_nltt_",i,".png",sep=""))
    nLTT.plot(file$species_trees_with_outgroup[[i]][[1]], main = paste(base_filename,"species tree with outgroup",i))
    dev.off()
  }
}
library(ape)
library(testit)
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/read_file.R")

plot_species_tree_with_outgroup <- function(filename) {
  assert(is_valid_file(filename))
  base_filename <- get_base_filename(filename)
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  for (i in seq(1,n_species_trees_samples)) {
    png(paste(base_filename,"_species_tree_with_outgroup_",i,".png",sep=""))
    plot(file$species_trees_with_outgroup[[i]][[1]], main = paste(base_filename,"species tree with outgroup",i))
    dev.off()
  }
}
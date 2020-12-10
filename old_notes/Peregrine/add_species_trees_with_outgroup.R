source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Phylogenies/add_outgroup_to_phylogeny.R")
source("~/GitHubs/R/Phylogenies/sample_species_trees_from_pbd_sim_output.R")
library(testit)

add_species_trees_with_outgroup <- function(filename) {
  assert(is_valid_file(filename))
  file <- read_file(filename)
  if(is.na(file$pbd_output[1])) {
    print(paste("file ",filename," needs a pbd_output",sep=""))
    return ()
  }
  parameters <- file$parameters
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])
  rng_seed <- as.numeric(parameters$rng_seed[2])
  print(paste("Adding species_trees_with_outgroup to file ",filename,sep=""))

  for (i in seq(1:n_species_trees_samples)) {
    if (!is.na(file$species_trees_with_outgroup[i])) 
    { 
      print(paste(" * species_trees_with_outgroup[",i,"] already exists",sep=""))
      next 
    }
    print(paste("   * Setting seed to ", (rng_seed + i), sep=""))
    set.seed(rng_seed + i) # Each species tree is generated from its own RNG seed
    species_tree <- sample_species_trees_from_pbd_sim_output(n = 1,file$pbd_output)[[1]]
    species_tree_with_outgroup <- add_outgroup_to_phylogeny(species_tree,stem_length = 0)
    assert(class(species_tree_with_outgroup) == "phylo")
    file$species_trees_with_outgroup[[i]] <- list(species_tree_with_outgroup)
    saveRDS(file,file=filename)
  }
  print(paste("Added species_trees_with_outgroup to file ",filename,sep=""))
}
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")
library(testit)

add_alignments <- function(filename) 
{
  assert(is_valid_file(filename))
  file <- read_file(filename)
  if(is.na(file$species_trees_with_outgroup[1])) {
    print(paste("file ",filename," needs a species_trees_with_outgroup",sep=""))
    return ()
  }
  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  assert(n_alignments > 0)
  sequence_length <- as.numeric(parameters$sequence_length[2])
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])
  assert(length(file$alignments) == n_alignments * n_species_trees_samples)
  for (i in seq(1,n_species_trees_samples)) {
    species_tree <- file$species_trees_with_outgroup[[i]][[1]]
    if (length(species_tree) == 1 && is.na(species_tree)) {
      print(paste("species_trees_with_outgroup[[", i, "]] is NA. Terminating 'add_alignments'",sep=""))
      return
    }
    for (j in seq(1,n_alignments)) {
      index <- 1 + (j - 1) + ( (i - 1) * n_species_trees_samples)
      if (class(file$alignments[[index]][[1]]) == "DNAbin") {
        print(paste("   * Already stored alignment #", j, " for species tree #",i," at index #", index, sep=""))
        next
      }
      new_seed <- rng_seed - 1 + j + ((i -1) * n_species_trees_samples)
      set.seed(new_seed)
      alignment <- convert_phylogeny_to_alignment(
        phylogeny = species_tree,
        sequence_length = sequence_length, 
        mutation_rate = mutation_rate
      )
      file$alignments[[index]] <- list(alignment)
      saveRDS(file,file=filename)
      print(paste("   * Created and saved alignments[",index,"]",sep=""))
    }
  }
  print(paste("file ",filename," has gotten its ", n_alignments, " alignments (per species tree)",sep=""))
}
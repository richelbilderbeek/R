source("~/GitHubs/R/Peregrine/read_libraries.R")

# InstallLibraries()
read_libraries()

add_alignments <- function(
  filename,
  do_plot = FALSE
) 
{
  file <- read_file(filename)
  assert(mode(file) == "list")
  
  if(is.na(file$species_trees_with_outgroup[1])) {
    print(paste("file ",filename," needs a species_trees_with_outgroup",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$pbd_output))
  assert(!is.null(file$species_trees_with_outgroup))
  assert(!is.null(file$alignments))
  assert(!is.null(file$posteriors))

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  assert(n_alignments > 0)
  sequence_length <- as.numeric(parameters$sequence_length[2])
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])

  assert(length(file$alignments) == n_alignments * n_species_trees_samples)
  
  # Create simulated DNA from species trees
  # For each of the n_species_trees_samples species_trees_with_outgroup
  #   create n_alignments
  for (i in seq(1,n_species_trees_samples)) {
    
    assert(i >= 1)
    assert(i <= length(file$species_trees_with_outgroup))
    species_tree <- file$species_trees_with_outgroup[[i]][[1]]

    assert(typeof(species_tree) == "list") #?Why
    assert(class(species_tree)  == "phylo")
    
    if (length(species_tree) == 1 && is.na(species_tree)) {
      print(paste("species_trees_with_outgroup[[", i, "]] is NA. Terminating 'add_alignments'",sep=""))
      return
    }
    print(paste(" * Added alignments to species tree #",i,sep=""))
    assert(class(species_tree) == "phylo")
    for (j in seq(1,n_alignments)) {

      index <- 1 + (j - 1) + ( (i - 1) * n_species_trees_samples)
      assert(index >= 1)
      assert(index <= length(file$alignments))

      if (class(file$alignments[[index]][[1]]) == "DNAbin") {
        print(paste("   * Already stored alignment #", j, " for species tree #",i," at index #", index, sep=""))
        next
      }

      new_seed <- rng_seed - 1 + j + ((i -1) * n_species_trees_samples)
      print(paste("   * Setting seed to", new_seed))
      set.seed(new_seed) # Each species tree is already generated from its own RNG seed
      
      print(paste("   * Creating alignment #", j, " for species tree #",i,sep=""))
      
      alignment <- convert_phylogeny_to_alignment(
        phylogeny = species_tree,
        sequence_length = sequence_length, 
        mutation_rate = mutation_rate
      )

      assert(is_alignment(alignment))

      print(paste("   * Created alignment #", j, " for species tree #",i,sep=""))
      if (do_plot) {
        image(alignment)
      }

      print(paste("   * Storing alignment #", j, " for species tree #",i," at index #", index, sep=""))
      file$alignments[[index]] <- list(alignment)
      assert(is_alignment(file$alignments[[index]][[1]]))

      saveRDS(file,file=filename)
      print(paste("   * Created and saved alignments[",index,"]",sep=""))
    }
  }
  
  assert(length(file$alignments) == n_alignments * n_species_trees_samples)
  assert(class(file$alignments[[1]][[1]])=="DNAbin")
  
  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(length(file_again$alignments) == length(file$alignments))
  assert(class(file_again$alignments[[1]][[1]])=="DNAbin")

  print(paste("file ",filename," has gotten its ", n_alignments, " alignments (per species tree)",sep=""))
}
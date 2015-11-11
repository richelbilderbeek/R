source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Phylogenies/SampleSpeciesTreesFromRandomProtractedTree.R")

# InstallLibraries()
ReadLibraries()

AddSpeciesTreesWithOutgroup <- function(
  filename,
  do_plot = FALSE
) {
  #file < "0.RDa"
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'species_trees_with_outgroup' this has already been done
  if(!is.null(file$species_trees_with_outgroup)) {
    print(paste("file ",filename," already has a species_trees_with_outgroup",sep=""))
    return ()
  }

  assert(!is.null(file$parameters))
  assert(!is.null(file$pbd_output))
  assert(is.null(file$species_trees_with_outgroup))

  parameters <- file$parameters
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])

  species_trees <- SampleSpeciesTreesFromPbdSimOutput(
    n = n_species_trees_samples,
    file$pbd_output
  )

  if (do_plot) {
    plot(species_trees[[1]])
    add.scale.bar(x=0,y=length(species_trees$tip.label))
    
    GetAverageNltt(
      species_trees,
      plot_nltts = TRUE, 
      main = "Sampled species trees (black) versus gene tree (red)"
    )
    nLTT.lines(
      file$pbd_output$tree,
      col = "red"
    )
  }

  # Add an outgroup
  species_trees_with_outgroup <- NULL
  for (species_tree in species_trees) {
    species_trees_with_outgroup <- c(
      species_trees_with_outgroup,
      list(AddOutgroupToPhylogeny(species_tree,stem_length = 0))
    )
  }
  
  if (do_plot) {
    plot(species_trees_with_outgroup[[1]])
    add.scale.bar(x=0,y=length(species_trees$tip.label))
  }
  
  # Append the species_trees_with_outgroup to file
  file <- c(file,list(species_trees_with_outgroup))
  names(file)[ length(file) ] <- "species_trees_with_outgroup"
  assert(all.equal(file$species_trees_with_outgroup,species_trees_with_outgroup))
  saveRDS(file,file=filename)

  # Read the file again to check integrity
  file_again <- readRDS(filename)
  assert(all.equal(file_again$species_trees_with_outgroup,species_trees_with_outgroup))

  assert(!is.null(file$species_trees_with_outgroup))
  print(paste("file ",filename," has gotten has a species_trees_with_outgroup",sep=""))
}
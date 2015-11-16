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

  parameters <- file$parameters
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])

  # If it already contains 'species_trees_with_outgroup' this has already been done
  if(length(file$species_trees_with_outgroup) == n_species_trees_samples) {
    print(paste("file ",filename," already has ",n_species_trees_samples," species_trees_with_outgroup",sep=""))
    return ()
  }
  print(paste("Adding species_trees_with_outgroup to file ",filename,sep=""))

  assert(!is.null(file$parameters))
  assert(!is.null(file$pbd_output))

  for (i in seq(1:n_species_trees_samples)) {
    if (!is.null(file$species_trees_with_outgroup)) 
    { 
      print(paste(" * species_trees_with_outgroup[",i,"] already exists",sep=""))
      next 
    }
    print(paste(" * Adding species_trees_with_outgroup[",i,"]",sep=""))
    species_tree <- SampleSpeciesTreesFromPbdSimOutput(n = 1,file$pbd_output)[1]
    species_tree_with_outgroup <- AddOutgroupToPhylogeny(species_tree,stem_length = 0)
    file$species_tree_with_outgroup[i] <- species_tree_with_outgroup

    saveRDS(file,file=filename)
    print(paste(" * Added species_trees_with_outgroup[",i,"]",sep=""))
  }
    
  if (do_plot) {
    plot(file$species_tree_with_outgroup[[1]])
    add.scale.bar(x=0,y=length(species_trees$tip.label))
    
    GetAverageNltt(
      file$species_tree_with_outgroup,
      plot_nltts = TRUE, 
      main = "Sampled species trees (black) versus gene tree (red)"
    )
    nLTT.lines(
      file$pbd_output$tree,
      col = "red"
    )
  }
  
  # Read the file again to check integrity
  file_again <- readRDS(filename)
  assert(all.equal(file_again$species_trees_with_outgroup,file$species_trees_with_outgroup))
  assert(!is.null(file$species_trees_with_outgroup))
  print(paste("Added species_trees_with_outgroup to file ",filename,sep=""))
}
library(testit)

source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Phylogenies/SampleSpeciesTreesFromRandomProtractedTree.R")
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
# InstallLibraries()
ReadLibraries()

add_species_trees_with_outgroup <- function(
  filename,
  do_plot = FALSE
) {
  #filename <- "0.RDa"
  file <- ReadFile(filename)
  assert(typeof(file) == "list")

  assert(!is.null(file$parameters))
  assert(!is.null(file$pbd_output))
  assert(!is.null(file$species_trees_with_output))
  assert(!is.null(file$alignments))
  assert(!is.null(file$posteriors))
  
  parameters <- file$parameters
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])

  # If it already contains 'species_trees_with_outgroup' this has already been done
  if(length(file$species_trees_with_outgroup) == n_species_trees_samples) {
    print(paste("file ",filename," already has ",n_species_trees_samples," species_trees_with_outgroup",sep=""))
    return ()
  }
  print(paste("Adding species_trees_with_outgroup to file ",filename,sep=""))

  assert(!is.null(file$parameters))
  assert(is.na(file$pbd_output[1])) # This changes here
  assert(is.na(file$species_trees_with_output[1]))
  assert(is.na(file$alignments[1]))
  assert(is.na(file$posteriors[1]))
  
  
  
  for (i in seq(1:n_species_trees_samples)) {
    if (!is.null(file$species_trees_with_outgroup)) 
    { 
      print(paste(" * species_trees_with_outgroup[",i,"] already exists",sep=""))
      next 
    }
    print(paste(" * Adding species_trees_with_outgroup[",i,"]",sep=""))
    print("   * sample_species_trees_from_pbd_sim_output")

    one_species_trees <- sample_species_trees_from_pbd_sim_output(n = 1,file$pbd_output)[1]
    assert(typeof(one_species_trees)=="list")
    assert(length(one_species_trees)==1)
    assert(class(one_species_trees[[1]])=="phylo")
    species_tree <- one_species_trees[[1]]

    print("   * add_outgroup_to_phylogeny")

    
    species_tree_with_outgroup <- add_outgroup_to_phylogeny(species_tree,stem_length = 0)
    print("   * write to file")
    file$species_trees_with_outgroup[i] <- species_tree_with_outgroup
    saveRDS(file,file=filename)
    print(paste(" * Added species_trees_with_outgroup[",i,"]",sep=""))
  }
    
  if (do_plot) {
    plot(file$species_tree_with_outgroup[[1]])
    add.scale.bar(x=0,y=length(species_trees$tip.label))
    
    get_average_nltt(
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

AddSpeciesTreesWithOutgroup <- function(
  filename,
  do_plot = FALSE
) {
  return (
    add_species_trees_with_outgroup(
      filename = filename,
      do_plot = do_plot
    )
  )
}
source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

AddAlignments <- function(filename)
{
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'alignments' this has already been done
  if(!is.null(file$alignments)) {
    print(paste("file ",filename," already has its alignments",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(is.null(file$alignments))
  

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  assert(n_alignments > 0)
  sequence_length <- as.numeric(parameters$sequence_length[2])

  set.seed(rng_seed)

  # Create simulated DNA from tree
  alignments <- NULL
  for (i in n_alignments) {
    alignment <- ConvertPhylogenyToRandomAlignments(
      phylogeny = file$phylogeny_with_outgroup,
      sequence_length = sequence_length, 
      mutation_rate = mutation_rate
    )
    assert(alignment == alignment)
    print(paste("#123",mode(alignment)))
    alignments <- c(alignments,alignment)
  }
  assert(alignments == alignments)
  
  # Add it to the file
  file <- c(file,list(alignments))
  names(file)[ length(file) ] <- "alignments"
  names(file)
  assert(file$parameters == parameters)
  assert(file$alignments == alignments)

  # Save the file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(file_again$alignments == alignments)

  assert(!is.null(file$alignments))
  print(paste("file ",filename," has gotten its ", n_alignments, "alignments",sep=""))
}
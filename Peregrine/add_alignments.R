source("~/GitHubs/R/Peregrine/read_libraries.R")

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
  for (i in seq(1,n_alignments)) {
    alignment <- ConvertPhylogenyToAlignment(
      phylogeny = file$phylogeny_with_outgroup,
      sequence_length = sequence_length, 
      mutation_rate = mutation_rate
    )
    assert(alignment == alignment)
    assert(class(alignment)=="DNAbin")
    image(alignment)
    alignments <- c(alignments,list(alignment))
  }
  
  assert(length(alignments) == n_alignments)
  assert(class(alignments[[1]])=="DNAbin")
  
  # Add it to the file
  file <- c(file,list(alignments))
  names(file)[ length(file) ] <- "alignments"
  names(file)
  assert(file$parameters == parameters)
  assert(length(file$alignments) == length(alignments))
  assert(class(alignments[[1]])=="DNAbin")
  assert(class(file$alignments[[1]])=="DNAbin")

  # Save the file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(length(file_again$alignments) == length(alignments))
  assert(class(file_again$alignments[[1]])=="DNAbin")

  assert(!is.null(file$alignments))
  print(paste("file ",filename," has gotten its ", n_alignments, "alignments",sep=""))
}
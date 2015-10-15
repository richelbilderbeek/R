source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

AddPosteriors <- function(
  filename,
  do_plot = FALSE
)
{
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'posterior' this has already been done
  if(!is.null(file$posterior)) {
    print(paste("file ",filename," already has its posteriors",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(!is.null(file$alignments))
  assert(is.null(file$posterior))

  parameters <- file$parameters
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  alignments <- file$alignments
  assert(length(alignments) > 0)

  posteriors <- NULL
  for (alignment in alignments) {
    posterior <- ConvertAlignmentToBeastPosterior(
      alignment = alignment,
      mcmc_chainlength = mcmc_chainlength,
      rng_seed = rng_seed
    )
    assert(all.equal(posterior,posterior))
    posteriors <- c(posteriors,posterior)
  }
  assert(all.equal(posteriors,posteriors))
  assert(length(posteriors) == length(alignments))
  
  # Add it to the file
  file <- c(file,list(posteriors))
  names(file)[ length(file) ] <- "posteriors"
  names(file)
  assert(file$parameters == parameters)
  assert(all.equal(file$posteriors,posteriors))

  # Save the file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(file_again$parameters == parameters)
  assert(all.equal(file_again$posteriors,posteriors))

  assert(!is.null(file$posteriors))
  print(paste("file ",filename," has gotten its posteriors",sep=""))
}
source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

ShowAlignments <- function(filename)
{
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'alignments' this has already been done
  if(is.null(file$alignments)) {
    print(paste("file ",filename," does not contain alignments",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(!is.null(file$alignments))

  alignments <- file$alignments
  print(mode(alignments))
  #assert(mode(file) == "list")

  assert(length(alignments) > 0)

  # Create simulated DNA from tree
  for (alignment in alignments) {
    image(alignment)
  }
}
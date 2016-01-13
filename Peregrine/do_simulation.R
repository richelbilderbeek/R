if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a parameter filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]
filename <- "1.RDa"

if (!file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}

source("~/GitHubs/R/Peregrine/add_pbd_output.R")
add_pbd_output(filename)  
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
add_species_trees_with_outgroup(filename)  
source("~/GitHubs/R/Peregrine/add_alignments.R")
add_alignments(filename)  
source("~/GitHubs/R/Peregrine/add_posteriors.R")
add_posteriors(filename)

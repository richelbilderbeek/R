if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a parameter filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]

if (!file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}

if (1==2) {
  setwd("~/GitHubs/R/Peregrine2")
  filename <- "example_4.RDa"
  assert(file.exists(filename))
}

source("~/GitHubs/R/Peregrine/add_pbd_output.R")
add_pbd_output(filename)  

source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
source("~/GitHubs/R/Peregrine/add_alignments.R")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
add_species_trees_with_outgroup(filename)  
add_alignments(filename, do_plot = FALSE)  
add_posteriors(filename)
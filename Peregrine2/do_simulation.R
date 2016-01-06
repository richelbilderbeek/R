if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a parameter filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]

if (!file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}

print("#1: Create the true phylogeny")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
add_pbd_output(filename)  

print("#2: Sample a species tree, adding an outgroup")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
add_species_trees_with_outgroup(filename)  

print("#3: Create the simulated alignments from each true phylogeny")
source("~/GitHubs/R/Peregrine/add_alignments.R")

add_alignments(filename, do_plot = FALSE)  
print("#4: Creating posteriors from alignments")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
add_posteriors(filename)
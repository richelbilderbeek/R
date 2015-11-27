filename <- "0.RDa"
rm(list = ls())

if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]

if (!file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}


source("~/GitHubs/R/Peregrine/install_libraries.R")
#InstallLibraries() #Run once if a package is missing

source("~/GitHubs/R/Peregrine/show_alignments.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
source("~/GitHubs/R/Peregrine/collect_files.R")



source("~/GitHubs/R/Peregrine/create_parameter_files_test.R")
source("~/GitHubs/R/Peregrine/create_parameter_files.R")
create_parameters_files()

print("#1: Create the true phylogeny")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
add_pbd_output(filename)  

print("#2: Sample a species tree, adding an outgroup")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
add_species_trees_with_outgroup(filename)  

print("#3: Create the simulated alignments from each true phylogeny")
source("~/GitHubs/R/Peregrine/add_alignments.R")
add_alignments(filename)  

print("#4: Creating posteriors from alignments")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
add_posteriors(filenamefilename)  
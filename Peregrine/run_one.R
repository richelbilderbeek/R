rm(list = ls())

if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]

if (file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}


source("~/GitHubs/R/Peregrine/install_libraries.R")
#InstallLibraries() #Run once if a package is missing

source("~/GitHubs/R/Peregrine/add_posteriors.R")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
source("~/GitHubs/R/Peregrine/add_alignments.R")
source("~/GitHubs/R/Peregrine/show_alignments.R")
source("~/GitHubs/R/Peregrine/create_parameter_files.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

ReadLibraries()

print("#1: Create parameter files")
TestCreateParametersFiles()
#CreateParametersFiles()

print("#2: Create the true phylogeny from each parameter file")
for (filename in CollectFiles()) {
  AddPbdOutput(filename)  
}

print("#3: Sample a species tree, adding an outgroup")
for (filename in CollectFiles()) {
  AddSpeciesTreesWithOutgroup(filename)  
}

print("#4: Create the simulated alignments from each true phylogeny")
for (filename in CollectFiles()) {
  AddAlignments(filename)  
}

#print("#5: Show the alignments")
#for (filename in CollectFiles()) { 
#  ShowAlignments(filename) 
#}

print("#6: Creating posteriors from alignments")
for (parameter_filename in CollectFiles()) {
  AddPosteriors(parameter_filename)  
}

#print("#7: Show the posteriors")
#for (parameter_filename in CollectFiles()) { 
#  ShowPosteriors(parameter_filename) 
#}
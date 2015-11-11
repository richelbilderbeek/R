rm(list = ls())
source("~/GitHubs/R/Peregrine/install_libraries.R")
#InstallLibraries() #Run once if a package is missing

source("~/GitHubs/R/Peregrine/add_posteriors.R")
source("~/GitHubs/R/Peregrine/add_phylogeny_with_outgroup.R")
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
CreateParametersFiles()

print("#2: Create the true phylogeny from each parameter file")
for (filename in CollectFiles()) {
  AddPhylogenyWithOutgroup(filename)  
}

print("#3: Create the simulated alignments from each true phylogeny")
for (filename in CollectFiles()) {
  AddAlignments(filename)  
}

print("#3: Show the alignments")
for (filename in CollectFiles()) { 
  ShowAlignments(filename) 
}

print("#4: Creating posteriors from alignments")
for (parameter_filename in CollectFiles()) {
  AddPosteriors(parameter_filename)  
}

print("#5: Show the posteriors")
for (parameter_filename in CollectFiles()) { 
  ShowPosteriors(parameter_filename) 
}
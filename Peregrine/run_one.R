# Runs one simulation

#
#
# parameters
#  |
#  | 1 (per parameter combination)
#  V
# pbd_output
#  |
#  | n_species_trees_samples (per pbd_output)
#  V
# species_trees_with_outgroup
#  |
#  | n_alignments (per species_trees_with_outgroup)
#  V
# alignments
#  |
#  |
#  V
# posteriors
#
#
#
#  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2]) # the extinction rate of incipient species 
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  assert(n_alignments > 0)
  sequence_length <- as.numeric(parameters$sequence_length[2])
  n_species_trees_samples <- as.numeric(parameters$n_species_trees_samples[2])

#
#
#


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

add_alignments(filename, do_plot = FALSE)  

print("#4: Creating posteriors from alignments")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
add_posteriors(filenamefilename)  

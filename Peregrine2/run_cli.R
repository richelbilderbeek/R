# Runs one simulation file, e.g. '0.RDa'
# A file has the following elements:
# * parameters: that file its parameter settings
# * pbd_output: the true gene tree
# * species_trees_with_outgroup: the true sampled species trees
# * alignments: the alignments simulation from the true samples species trees
# * posteriors: the inferred BEAST2 posteriors of the alignments
#
# A run has the following chronology:
#
# parameters (always present)
#  |
#  | 1 (per parameter combination)
#  V
# pbd_output (1)
#  |
#  | n_species_trees_samples (per pbd_output)
#  V
# species_trees_with_outgroup (1 * n_species_trees_samples)
#  |
#  | n_alignments (per species_trees_with_outgroup)
#  V
# alignments (1 * n_species_trees_samples * n_alignments)
#  |
#  | n_beast_runs (per alignment)
#  V
# posteriors (1 * n_species_trees_samples * n_alignments * n_beast_runs)
#

#filename <- "0.RDa"
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

#source("~/GitHubs/R/Peregrine/create_parameter_files_test.R")
#source("~/GitHubs/R/Peregrine/create_parameter_files.R")
#create_parameters_files() 

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

print("#5: Create some plots")
source("~/GitHubs/R/Peregrine/add_posteriors.R")

print("DONE")

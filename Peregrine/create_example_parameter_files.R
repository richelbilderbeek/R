# Step #1
# Creates files with filename [number].RDa that
# contain the parameters of interest.
source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")
source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")

library(testit)

create_example_parameters_files <- function () {
  save_parameters_to_file(
    rng_seed = 42,
    species_initiation_rate_good_species = 0.5, 
    species_initiation_rate_incipient_species = 0.5,  
    speciation_completion_rate = 1.0,  
    extinction_rate_good_species = 0.1,
    extinction_rate_incipient_species = 0.1,
    age = 5,
    n_species_trees_samples = 1,
    mutation_rate = 0.01,
    n_alignments = 1,
    sequence_length = 1000,
    mcmc_chainlength = 1000000,
    n_beast_runs = 1,
    filename = "example1.RDa"
  )
}

create_example_parameters_files()

#source("~/GitHubs/R/Peregrine/run_one.R")
#run_one()

print("#1: Create the true phylogeny")
source("~/GitHubs/R/Peregrine/add_pbd_output.R")
add_pbd_output("example1.RDa")  



print("#2: Sample a species tree, adding an outgroup")
source("~/GitHubs/R/Peregrine/add_species_trees_with_outgroup.R")
add_species_trees_with_outgroup(filename)  

print("#3: Create the simulated alignments from each true phylogeny")
source("~/GitHubs/R/Peregrine/add_alignments.R")

add_alignments(filename, do_plot = FALSE)  
print("#4: Creating posteriors from alignments")
source("~/GitHubs/R/Peregrine/add_posteriors.R")
add_posteriors(filename)  

print("DONE")

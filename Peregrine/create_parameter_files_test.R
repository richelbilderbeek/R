source("~/GitHubs/R/Peregrine/create_parameter_files.R")
source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")
source("~/GitHubs/R/Phylogenies/is_pbd_sim_output.R")
source("~/GitHubs/R/Phylogenies/is_alignment.R")
source("~/GitHubs/R/Phylogenies/is_beast_posterior.R")
library(testit)

create_parameters_files_test <- function() {
  rng_seed <- 42
  species_initiation_rate_good_species  <- 0.2 # the speciation-initiation rate of good species
  species_initiation_rate_incipient_species  <- 0.2 # the speciation-initiation rate of incipient species 
  speciation_completion_rate <- 1.0 # the speciation-completion rate 
  extinction_rate_good_species <- 0.1 # the extinction rate of good species 
  extinction_rate_incipient_species <- 0.1 # the extinction rate of incipient species 
  age <- 15
  n_species_trees_samples <- 10
  mutation_rate <- 0.1
  n_alignments <- 10
  sequence_length <- 100
  mcmc_chainlength <- 1000000
  n_beast_runs <- 2
  filename <- "1_tmp.txt"
  save_parameters_to_file(
    rng_seed = rng_seed,
    species_initiation_rate_good_species = species_initiation_rate_good_species, # the speciation-initiation rate of good species
    species_initiation_rate_incipient_species = species_initiation_rate_incipient_species, # the speciation-initiation rate of incipient species 
    speciation_completion_rate = speciation_completion_rate, # the speciation-completion rate 
    extinction_rate_good_species = extinction_rate_good_species, # the extinction rate of good species 
    extinction_rate_incipient_species = extinction_rate_incipient_species, # the extinction rate of incipient species 
    age = age,
    n_species_trees_samples = n_species_trees_samples,
    mutation_rate = mutation_rate,
    n_alignments = n_alignments,
    sequence_length = sequence_length,
    mcmc_chainlength = mcmc_chainlength,
    n_beast_runs = n_beast_runs,
    filename = filename
  )
  
  assert(file.exists(filename))
  parametersfile <- load_parameters_from_file(filename)
  
  assert(rng_seed == as.numeric(parametersfile$parameters$rng_seed[2]))
  assert(species_initiation_rate_good_species  == as.numeric(parametersfile$parameters$species_initiation_rate_good_species[2]))
  assert(species_initiation_rate_incipient_species  == as.numeric(parametersfile$parameters$species_initiation_rate_incipient_species[2]))
  assert(speciation_completion_rate == as.numeric(parametersfile$parameters$speciation_completion_rate[2]))
  assert(extinction_rate_good_species == as.numeric(parametersfile$parameters$extinction_rate_good_species[2]))
  assert(extinction_rate_incipient_species == as.numeric(parametersfile$parameters$extinction_rate_incipient_species[2]))
  assert(age == as.numeric(parametersfile$parameters$age[2]))
  assert(n_species_trees_samples == as.numeric(parametersfile$parameters$n_species_trees_samples[2]))
  assert(mutation_rate == as.numeric(parametersfile$parameters$mutation_rate[2]))
  assert(n_alignments == as.numeric(parametersfile$parameters$n_alignments[2]))
  assert(sequence_length == as.numeric(parametersfile$parameters$sequence_length[2]))
  assert(mcmc_chainlength == as.numeric(parametersfile$parameters$mcmc_chainlength[2]))
  assert(n_beast_runs == as.numeric(parametersfile$parameters$n_beast_runs[2]))
  

  assert(!is.null(parametersfile$parameters))
  assert(!is.null(parametersfile$pbd_output))
  assert(!is.null(parametersfile$species_trees_with_outgroup))
  assert(!is.null(parametersfile$alignments))
  assert(!is.null(parametersfile$posteriors))
  
  assert(length(parametersfile$pbd_output) == 1)
  assert(length(parametersfile$species_trees_with_outgroup) == n_species_trees_samples)
  assert(length(parametersfile$alignments) == n_species_trees_samples * n_alignments)
  assert(length(parametersfile$posteriors) == n_species_trees_samples * n_alignments * n_beast_runs)

  assert(!is_pbd_sim_output(parametersfile$pbd_output))
  assert(!is_alignment(parametersfile$alignments[[1]]))
  assert(!is_beast_posterior(parametersfile$posteriors[[1]]))
  
  file.remove(filename) # Get rid of that test file
  print("create_parameters_files: OK")
}

create_parameters_files_test()

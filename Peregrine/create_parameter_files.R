# Step #1
# Creates files with filename [number].RDa that
# contain the parameters of interest.
library(testit)

LoadParametersFromFile <- function(filename) {
  assert(file.exists(filename))
  my_table <- readRDS(filename)
}

SaveParametersToFile <- function(
  rng_seed,
  species_initiation_rate_good_species,
  species_initiation_rate_incipient_species,
  speciation_completion_rate,
  extinction_rate_good_species,
  extinction_rate_incipient_species,
  age,
  n_species_trees_samples,
  mutation_rate,
  n_alignments,
  sequence_length,
  mcmc_chainlength,
  filename
) {

  my_table <- data.frame( row.names = c("Description","Value"))
  my_table[, "rng_seed"] <- c("Random number generate seed",rng_seed)
  my_table[, "species_initiation_rate_good_species"] <- c("Speciation initiation rate of good species",species_initiation_rate_good_species)
  my_table[, "species_initiation_rate_incipient_species"] <- c("Speciation initiation rate of incipient species",species_initiation_rate_incipient_species)
  my_table[, "speciation_completion_rate"] <- c("Speciation completion rate",speciation_completion_rate)
  my_table[, "extinction_rate_good_species"] <- c("Extinction rate of good species",extinction_rate_good_species)
  my_table[, "extinction_rate_incipient_species"] <- c("Extinction rate of incipient species",extinction_rate_incipient_species)
  my_table[, "age"] <- c("Phylogenetic tree crown age",age)
  my_table[, "n_species_trees_samples"] <- c("Number of species trees sampled from a gene tree",n_species_trees_samples)
  
  my_table[, "mutation_rate"] <- c("DNA mutation rate",mutation_rate)
  my_table[, "n_alignments"] <- c("Number of DNA alignments",n_alignments)
  my_table[, "sequence_length"] <- c("DNA sequence length",sequence_length)
  my_table[, "mcmc_chainlength"] <- c("MCMC chain length",mcmc_chainlength)
  
  my_list <- list(my_table)
  names(my_list) <- c("parameters")
  assert(my_list$parameters == my_table)
  
  
  saveRDS(my_list,file=filename)
  assert(file.exists(filename))
  
  my_list_again <- readRDS(filename)
  # Check that the original and loaded data frame were identical
  assert(length(my_list) == length(my_list_again))
  assert(my_list$parameters == my_list_again$parameters)

  assert(rng_seed == as.numeric(my_list$parameters$rng_seed[2]))
  assert(species_initiation_rate_good_species  == as.numeric(my_list$parameters$species_initiation_rate_good_species[2]))
  assert(species_initiation_rate_incipient_species  == as.numeric(my_list$parameters$species_initiation_rate_incipient_species[2]))
  assert(speciation_completion_rate == as.numeric(my_list$parameters$speciation_completion_rate[2]))
  assert(extinction_rate_good_species == as.numeric(my_list$parameters$extinction_rate_good_species[2]))
  assert(extinction_rate_incipient_species == as.numeric(my_list$parameters$extinction_rate_incipient_species[2]))
  assert(age == as.numeric(my_list$parameters$age[2]))
  assert(n_alignments == as.numeric(my_list$parameters$n_alignments[2]))
  assert(mutation_rate == as.numeric(my_list$parameters$mutation_rate[2]))
  assert(sequence_length == as.numeric(my_list$parameters$sequence_length[2]))
  assert(mcmc_chainlength == as.numeric(my_list$parameters$mcmc_chainlength[2]))
}

TestCreateParametersFiles <- function() {
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
  filename <- "1_tmp.txt"
  SaveParametersToFile(
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
    filename = filename
  )
  
  assert(file.exists(filename))
  parametersfile <- LoadParametersFromFile(filename)
  
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
  file.remove(filename) # Get rid of that test file
}

CreateParametersFiles <- function () {

  file_index <- 0

  for (rng_seed in c(42)) {
    for (species_initiation_rate_good_species in c(0.5)) { # the speciation-initiation rate of good species
      species_initiation_rate_incipient_species <- species_initiation_rate_good_species # the speciation-initiation rate of incipient species
      for (speciation_completion_rate in c(0.1, 0.3, 1.0)) { # the speciation-completion rate
        for (extinction_rate_good_species in c(0, 0.1, 0.2)) {
          extinction_rate_incipient_species <- extinction_rate_good_species
          for (age in c(15)) {
            for (n_species_trees_samples in c(2)) {
              for (mutation_rate in c(0.01, 0.001)) {
                for (n_alignments in c(2)) {
                  for (sequence_length in c(1000,10000)) {
                    mcmc_chainlength <- 1000000
                    filename <- paste(file_index,".RDa",sep="")
                    SaveParametersToFile(
                      rng_seed = rng_seed,
                      species_initiation_rate_good_species = species_initiation_rate_good_species, 
                      species_initiation_rate_incipient_species = species_initiation_rate_incipient_species,  
                      speciation_completion_rate = speciation_completion_rate,  
                      extinction_rate_good_species = extinction_rate_good_species,
                      extinction_rate_incipient_species = extinction_rate_incipient_species,
                      age = age,
                      n_species_trees_samples = n_species_trees_samples,
                      mutation_rate = mutation_rate,
                      n_alignments = n_alignments,
                      sequence_length = sequence_length,
                      mcmc_chainlength = mcmc_chainlength,
                      filename = filename
                    )
                    print(paste("Created file ",filename,sep=""))
                    file_index <- file_index + 1
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}    
    

#TestCreateParametersFiles()

#CreateParametersFiles()

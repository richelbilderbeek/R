source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")

create_parameters_files <- function () {
  file_index <- 0
  for (rng_seed in c(42)) {
    for (species_initiation_rate_good_species in c(0.5)) {
      species_initiation_rate_incipient_species <- species_initiation_rate_good_species
      for (speciation_completion_rate in c(0.1, 0.3, 1.0)) {
        for (extinction_rate_good_species in c(0, 0.1, 0.2)) {
          extinction_rate_incipient_species <- extinction_rate_good_species
          for (age in c(5)) {
            for (n_species_trees_samples in c(2)) {
              for (mutation_rate in c(0.01, 0.001)) {
                for (n_alignments in c(2)) {
                  for (sequence_length in c(1000,10000)) {
                    mcmc_chainlength <- 1000000
                    n_beast_runs <- 2
                    filename <- paste(file_index,".RDa",sep="")
                    save_parameters_to_file(
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
                      n_beast_runs = n_beast_runs,
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

create_parameters_files()
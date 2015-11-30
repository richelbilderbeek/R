# Step #1
# Creates files with filename [number].RDa that
# contain the parameters of interest.
library(testit)

save_parameters_to_file <- function(
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
  n_beast_runs,
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
  my_table[, "n_alignments"] <- c("Number of DNA alignments per species tree",n_alignments)
  my_table[, "sequence_length"] <- c("DNA sequence length",sequence_length)
  my_table[, "mcmc_chainlength"] <- c("MCMC chain length",mcmc_chainlength)
  my_table[, "n_beast_runs"] <- c("Number of BEAST2 runs per alignment",n_beast_runs)
  my_table[, "version"] <- c("Parameter file version","0.1")
  # Create the slots for the results
  #rep(x = NULL, times = 10) HIERO
  
  
  my_list <- list(
    my_table, #parameters
    NA, # pbd_output
    rep(x = NA, times = n_species_trees_samples), # species_trees_with_outgroup
    rep(x = NA, times = n_species_trees_samples * n_alignments), # alignments
    rep(x = NA, times = n_species_trees_samples * n_alignments * n_beast_runs) # posteriors
  )
  names(my_list) <- c(
    "parameters",
    "pbd_output",
    "species_trees_with_outgroup",
    "alignments",
    "posteriors"
  )
  assert(my_list$parameters == my_table)
  
  assert(!is.null(my_list$parameters))
  assert(!is.null(my_list$pbd_output))
  assert(!is.null(my_list$species_trees_with_outgroup))
  assert(!is.null(my_list$alignments))
  assert(!is.null(my_list$posteriors))

  assert(!is.null(my_list$parameters))
  assert(is.na(my_list$pbd_output[1]))
  assert(is.na(my_list$species_trees_with_outgroup[1]))
  assert(is.na(my_list$alignments[1]))
  assert(is.na(my_list$posteriors[1]))

  assert(length(my_list$pbd_output) == 1)
  assert(length(my_list$species_trees_with_outgroup) == n_species_trees_samples)
  assert(length(my_list$alignments) == n_species_trees_samples * n_alignments)
  assert(length(my_list$posteriors) == n_species_trees_samples * n_alignments * n_beast_runs)

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
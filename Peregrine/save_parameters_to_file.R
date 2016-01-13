library(testit)
source("~/GitHubs/R/Peregrine/is_valid_file.R")

save_parameters_to_file <- function(
  rng_seed,
  species_initiation_rate_good_species, 
  species_initiation_rate_incipient_species,
  speciation_completion_rate,
  extinction_rate_good_species,
  extinction_rate_incipient_species,
  age, n_species_trees_samples,
  mutation_rate, n_alignments,
  sequence_length, mcmc_chainlength,
  n_beast_runs, filename
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
  assert(length(my_list$pbd_output) == 1)
  assert(length(my_list$species_trees_with_outgroup) == n_species_trees_samples)
  assert(length(my_list$alignments) == n_species_trees_samples * n_alignments)
  assert(length(my_list$posteriors) == n_species_trees_samples * n_alignments * n_beast_runs)

  saveRDS(my_list,file=filename)
  assert(is_valid_file(filename))
}
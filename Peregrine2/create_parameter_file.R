argv <- commandArgs(trailingOnly = TRUE)
if (length(argv) == 0) {
  argv <- c("42","0.5","0.5","1000000","0.1","0.1","5","2","0.01","2","1000","1000000","2","1.RDa")
}

if (length(argv) != 14) {
  print("Please supply 14 arguments, for example:" )
  print("Rscript create_parameter_file.R 42 0.5 0.5 1000000 0.1 0.1 5 2 0.01 2 1000 1000000 2 1.RDa" )
  stop()
}

for (i in seq(1,13)) {
  if (is.na(as.numeric(argv[i]))) {
    print("Please supply 13 values, for example:" )
    print("Rscript create_parameter_file.R 42 0.5 0.5 1000000 0.1 0.1 5 2 0.01 2 1000 1000000 2 1.RDa" )
    stop()
  }
}

source("~/GitHubs/R/Peregrine/save_parameters_to_file.R")

save_parameters_to_file(
  rng_seed = as.numeric(argv[1]),
  species_initiation_rate_good_species = as.numeric(argv[2]), 
  species_initiation_rate_incipient_species = as.numeric(argv[3]),  
  speciation_completion_rate = as.numeric(argv[4]),  
  extinction_rate_good_species = as.numeric(argv[5]),
  extinction_rate_incipient_species = as.numeric(argv[6]),
  age = as.numeric(argv[7]),
  n_species_trees_samples = as.numeric(argv[8]),
  mutation_rate = as.numeric(argv[9]),
  n_alignments = as.numeric(argv[10]),
  sequence_length = as.numeric(argv[11]),
  mcmc_chainlength = as.numeric(argv[12]),
  n_beast_runs = as.numeric(argv[13]),
  filename = argv[14]
)
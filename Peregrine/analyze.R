source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")

file <- load_parameters_from_file("~/Slurm/0.RDa")
print(file$parameters)
print(names(file))

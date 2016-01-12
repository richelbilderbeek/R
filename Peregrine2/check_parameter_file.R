if (length(commandArgs(TRUE)) != 1) {
  print("Please supply a parameter filename" )
  stop()
}

filename <- commandArgs(TRUE)[1]

if (!file.exists(filename)) {
  print("Please supply the filename of an existing file" )
  stop()
}

source("~/GitHubs/R/Peregrine/load_parameters_from_file.R")

file <- load_parameters_from_file(filename)
print(t(file$parameters[2,]))

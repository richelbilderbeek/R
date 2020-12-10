args <- commandArgs(TRUE)
if (length(args) == 0) {
  print("Please supply the parameter filename(s)" )
  stop()
}

for (filename in args) {
  if (!file.exists(filename)) {
    print(paste(filename,": not found"), sep="")
    print("Please supply the filename(s) of (an) existing file(s)" )
    stop()
  }
}

if (length(args) == 1) {
  print("Analyzing one parameter file")
  source("~/GitHubs/R/Peregrine/analyse_single.R")
  analyse_single(args[1])
} else {
  print("Analyzing multiple parameter files")
  source("~/GitHubs/R/Peregrine/analyse_multi.R")
  analyse_multi(args)
}
if (length(commandArgs(TRUE)) == 0) {
  print("Please supply the parameter filename(s)" )
  stop()
}

for (filename in commandArgs(TRUE)) {
  if (!file.exists(filename)) {
    print(paste(filename,": not found"), sep="")
    print("Please supply the filename(s) of (an) existing file(s)" )
    stop()
  }
}


if (length(commandArgs(TRUE)) == 1) {
  print("Analyzing one parameter file")
  source("~/GitHubs/R/Peregrine2/do_analyze_single.R")
  do_analyze_single(commandArgs(TRUE)[1])
} else {
  print("Analyzing multiple parameter files")
  source("~/GitHubs/R/Peregrine2/do_analyze_multi.R")
  do_analyze_multi(commandArgs(TRUE))
}
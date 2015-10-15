# Step #2
# Reads parameter file '[number].RDa'. If that file has no $data
# sections, it adds simulated data

#
# Simulated data:
#  * original tree
#  * mutiple sequence alignments

source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

ReadFile <- function(filename)
{
  assert(file.exists(filename))
  file <- readRDS(filename)
}

#filename = "1.RDa"
#do_plot = FALSE




print("Creating phylognies from parameters")
for (filename in CollectFiles()) {
  AddPhylogenyWithOutgroup(paste("~/",filename,sep=""))  
}

print("Creating alignments from phylogenies")
for (filename in CollectFiles()) {
  AddAlignments(paste("~/",filename,sep=""),do_plot = TRUE)  
  #ShowAlignments(paste("~/",filename,sep=""))  
}

stop()

AddPosteriors("~/1.RDa")

print("Creating posterioirs from alignments")
for (parameter_filename in CollectFiles()) {
  AddPosteriors(paste("~/",parameter_filename,sep=""))  
  #RunExperiment(paste("~/",parameter_filename,sep=""))  
}

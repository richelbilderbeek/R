source("~/GitHubs/R/Peregrine/create_parameter_files.R")
source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

print("#1: Create parameter files")
CreateParametersFiles()

print("#2: Create the true phylogeny from each parameter file")
for (filename in CollectFiles()) {
  AddPhylogenyWithOutgroup(paste("~/",filename,sep=""))  
}

print("#3: Create the simulated alignments from each true phylogeny")
for (filename in CollectFiles()) {
  AddAlignments(paste("~/",filename,sep=""))  
  ShowAlignments(paste("~/",filename,sep=""))  
}


stop()

ShowAlignments("~1.RDa")  

print("Creating posterioirs from alignments")
for (parameter_filename in CollectFiles()) {
  AddPosteriors(paste("~/",parameter_filename,sep=""))  
  #RunExperiment(paste("~/",parameter_filename,sep=""))  
}

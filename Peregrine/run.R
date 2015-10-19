source("~/GitHubs/R/Peregrine/add_posteriors.R")
source("~/GitHubs/R/Peregrine/add_phylogeny_with_outgroup.R")
source("~/GitHubs/R/Peregrine/add_alignments.R")
source("~/GitHubs/R/Peregrine/show_alignments.R")
source("~/GitHubs/R/Peregrine/create_parameter_files.R")
source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Peregrine/show_posteriors.R")
source("~/GitHubs/R/Peregrine/collect_files.R")

# InstallLibraries()
ReadLibraries()

print("#1: Create parameter files")
TestCreateParametersFiles()
CreateParametersFiles()

print("#2: Create the true phylogeny from each parameter file")
for (filename in CollectFiles()) {
  AddPhylogenyWithOutgroup(paste("~/",filename,sep=""))  
}

print("#3: Create the simulated alignments from each true phylogeny")
for (filename in CollectFiles()) {
  AddAlignments(paste("~/",filename,sep=""))  
}

print("#3: Show the alignments")
for (filename in CollectFiles()) { ShowAlignments(paste("~/",filename,sep="")) }

print("#4: Creating posteriors from alignments")
for (parameter_filename in CollectFiles()) {
  AddPosteriors(paste("~/",parameter_filename,sep=""))  
  #RunExperiment(paste("~/",parameter_filename,sep=""))  
}

print("#5: Show the posteriors")
for (parameter_filename in CollectFiles()) { ShowPosteriors(paste("~/",parameter_filename,sep="")) }


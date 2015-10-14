# Step #2
# Reads parameter file '[number]_parameters.txt' and
# creates files with filename [number]_data.txt that
# contain the simulated data
# These will be used to create [number]_result.txt files

#
# Simulated data:
#  * original tree
#  * mutiple sequence alignments

source("~/GitHubs/R/Peregrine/install_libraries.R")
source("~/GitHubs/R/Peregrine/read_libraries.R")

# InstallLibraries()
ReadLibraries()

CollectParameterFiles <- function() {
  result_files <- list.files(
    path = ".", 
    pattern = ".RDa",
  )
}

ReadParameters <- function(parameters_filename)
{
  assert(file.exists(parameters_filename))
  parameters <- readRDS(parameters_filename)
}

ProcessParametersFile <- function(
  parameters_filename,
  do_plot = FALSE
)
{
  #parameters_filename <- "~/1.txt"
  #do_plot = FALSE

  ###############################
  #
  # Read parameters from file
  # Create/extract all parameters
  # 
  ###############################
  parameters <- ReadParameters(parameters_filename)
  mutation_rate <- as.numeric(parameters$mutation_rate[2])
  sequence_length <- as.numeric(parameters$sequence_length[2])
  mcmc_chainlength <- as.numeric(parameters$mcmc_chainlength[2])
  output_filename <- gsub("_parameters.txt","_data.txt",parameters_filename)
  if (file.exists(output_filename)) return
    
  # File paths for BeastScripter
  beast_scripter_path <- "~/Programs/BeastScripter/BeastScripterConsole"
  base_filename <- "test_output_1"
  fasta_filename <- paste(base_filename,".fasta",sep="");
  beast_filename <- paste(base_filename,".xml",sep="");
  beast_path <- "~/Programs/BEAST/bin/beast"
  beast_log_filename <- paste(base_filename,".log",sep="");
  beast_trees_filename <- paste(base_filename,".trees",sep="");
  beast_state_filename <- paste(base_filename,".xml.state",sep="");
  
  assert(file.exists(beast_scripter_path))
  assert(file.exists(beast_path))
  
  ###############################
  #
  # Run the experiment
  #
  ###############################
  set.seed(parameters$rng_seed[2])
  
  # Create reconstructed protracted simulated tree
  b_1  <- as.numeric(parameters$b_1[2]) # the speciation-initiation rate of good species
  b_2  <- as.numeric(parameters$b_2[2]) # the speciation-initiation rate of incipient species 
  la_1 <- as.numeric(parameters$la_1[2]) # the speciation-completion rate 
  mu_1 <- as.numeric(parameters$mu_1[2]) # the extinction rate of good species 
  mu_2 <- as.numeric(parameters$mu_2[2]) # the extinction rate of incipient species 
  #age <- as.numeric(parameters$age[2])
  tree_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age=as.numeric(parameters$age[2]),soc=2,plot=do_plot)
  if (do_plot) {
    par(mfrow=c(1,1)) # Bug fix of https://github.com/richelbilderbeek/Wip/issues/20
  }
  
  phylogeny <- tree_full$tree
  assert(is.rooted(phylogeny))
  assert(is.ultrametric(phylogeny))
  if (do_plot) {
    plot(phylogeny,main="True tree")
    add.scale.bar()
  }
  
  # Add an outgroup
  phylogeny_with_outgroup <- AddOutgroupToPhylogeny(phylogeny,stem_length = 0)

  if (do_plot) {
    plot(phylogeny_with_outgroup)
    add.scale.bar(x=0,y=length(phylogeny_with_outgroup$tip.label))
  }
  
  # Create simulated DNA from tree
  alignments <- ConvertPhylogenyToRandomAlignments(
    phylogeny_with_outgroup,
    sequence_length, 
    mutation_rate = as.numeric(parameters$mutation_rate[2])
  )

  if (do_plot) {
    image(alignments)
  }
  
  # Save to FASTA file
  ConvertAlignmentsToFasta(alignments,fasta_filename)
  
  # Create BEAST2 parameter file from FASTA file and aparameters
  cmd <- paste(
    beast_scripter_path, 
    " --fasta ",fasta_filename,
    " --mcmc_length ",mcmc_chainlength,
    " --tree_prior ","birth_death",
    " --output_file ",beast_filename,
    " --silent",
    sep=""
  )
  system(cmd)
  assert(file.exists(beast_filename))
  
  # Run BEAST2, needs the BEAST2 .XML parameter file
  # Prevent BEAST prompting the user whether to overwrite the log file
  if (file.exists(beast_trees_filename)) { file.remove(beast_trees_filename) }
  if (file.exists(beast_log_filename)) { file.remove(beast_log_filename) }
  if (file.exists(beast_state_filename)) { file.remove(beast_state_filename) }
  
  cmd <- paste(
    beast_path, 
    " -seed ",parameters$rng_seed[2],
    " ",beast_filename,
    sep=""
  )
  system(cmd)
  assert(file.exists(beast_trees_filename))
  assert(file.exists(beast_log_filename))
  assert(file.exists(beast_state_filename))
  
  ###############################
  #
  # Save the results to file
  #
  ###############################
  
  # Analyse posterior
  # Read all trees from the BEAST2 posterior
  all_trees <- beast2out.read.trees(beast_trees_filename)
    
  my_list <- list(
    parameters,
    phylogeny_with_outgroup,
    all_trees
  )
  names(my_list) <- c("parameters","phylogeny_with_outgroup","posterior")
  saveRDS(my_list,file=output_filename)
}

for (parameter_filename in CollectParameterFiles()) {
  RunExperiment(paste("~/",parameter_filename,sep=""))  
}

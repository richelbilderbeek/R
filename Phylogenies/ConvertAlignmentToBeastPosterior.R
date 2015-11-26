library(ape)
library(geiger)
library(phangorn)
source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignment.R")
source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentToFasta.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentToBeastInputFile.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")

# alignment_dnabin <- CreateRandomAlignment(5,10)
# mcmc_chainlength = 10000
#rng_seed <- 42
convert_alignment_to_beast_posterior <- function(
  alignment_dnabin,
  mcmc_chainlength,
  base_filename,
  rng_seed = 42
) {
  # File paths
  #base_filename <- "test_output_1"
  beast_filename <- paste(base_filename,".xml",sep="");
  beast_bin_path <- "~/Programs/BEAST/bin/beast"
  beast_jar_path <- "~/Programs/BEAST/lib/beast.jar"
  beast_log_filename <- paste(base_filename,".log",sep="");
  beast_trees_filename <- paste(base_filename,".trees",sep="");
  beast_state_filename <- paste(base_filename,".xml.state",sep="");

  # Check prerequisites
  if (!file.exists(beast_bin_path))
  {
    print(paste("BEAST2 binary not found at path '",beast_bin_path,"'",sep=""))
    stop()
  }
  assert(file.exists(beast_bin_path))
  if (!file.exists(beast_jar_path))
  {
    print(paste("BEAST2 jar not found at path '",beast_bin_path,"'",sep=""))
    stop()
  }
  assert(file.exists(beast_jar_path))
  
  # Create a BEAST2 XML input file
  convert_alignment_to_beast_input_file(
    alignment_dnabin = alignment_dnabin,
    mcmc_chainlength = mcmc_chainlength,
    rng_seed = rng_seed,
    beast_filename = beast_filename
  )
  assert(file.exists(beast_filename))
  
  # Run BEAST2, needs the BEAST2 .XML parameter file
  # Prevent BEAST prompting the user whether to overwrite the log file
  if (file.exists(beast_trees_filename)) { file.remove(beast_trees_filename) }
  if (file.exists(beast_log_filename)) { file.remove(beast_log_filename) }
  if (file.exists(beast_state_filename)) { file.remove(beast_state_filename) }

  # Call BEAST2 binary file directly
  {
    # This may result in the following error:
    #
    #   Invalid maximum heap size: -Xmx4g
    #   The specified size exceeds the maximum representable size.
    #   Error: Could not create the Java Virtual Machine.
    #   Error: A fatal exception has occurred. Program will exit.
    #
    # Therefore, there is another go below to call BEAST
    cmd <- paste(
      beast_bin_path, 
      " -seed ",rng_seed,
      " ", beast_filename,
      sep=""
    )
    system(cmd)
  }
  
  # Call BEAST2 jar
  if (!file.exists(beast_trees_filename)) {
    cmd <- paste(
      "java -jar ", beast_jar_path, 
      " -seed ", rng_seed,
      " ", beast_filename,
      sep=""
    )
    system(cmd)
  }
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
  posterior <- beast2out.read.trees(beast_trees_filename)
}  

# Convert an alignment to a BEAST2 XML input file

library(ape)
library(geiger)
library(phangorn)
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")
source("~/GitHubs/R/Phylogenies/create_random_alignment.R")
source("~/GitHubs/R/Phylogenies/add_outgroup_to_phylogeny.R")
source("~/GitHubs/R/Phylogenies/convert_alignment_to_fasta.R")
source("~/GitHubs/R/Phylogenies/convert_alignment_to_beast_input_file.R")
source("~/GitHubs/R/Math/is_whole_number.R")
source("~/GitHubs/R/Math/is_string.R")

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
  assert(is_alignment(alignment_dnabin))
  assert(is_whole_number(mcmc_chainlength))
  assert(mcmc_chainlength > 0)
  assert(is_string(base_filename))
  assert(is_whole_number(rng_seed))

  # File paths
  #base_filename <- "test_output_1"
  beast_filename <- paste(base_filename,".xml",sep="");
  beast_bin_path <- "~/Programs/BEAST2/bin/beast"
  beast_jar_path <- "~/Programs/BEAST2/lib/beast.jar"
  beast_log_filename <- paste(base_filename,".log",sep="");
  beast_trees_filename <- paste(base_filename,".trees",sep="");
  beast_state_filename <- paste(base_filename,".xml.state",sep="");
  temp_fasta_filename <- paste(base_filename,".fasta",sep="");

  # Check prerequisites
  if (!file.exists(beast_bin_path) && !file.exists(beast_jar_path)) {
    stop(
      "ERROR: BEAST2 binary not found at path '",
      beast_bin_path,
      "', BEAST2 jar not found at path '",
      beast_jar_path,
      "'"
    )
  }
  if (!file.exists(beast_bin_path))
  {
    print(paste("BEAST2 binary not found at path '",beast_bin_path,"'",sep=""))
  }
  if (!file.exists(beast_jar_path))
  {
    print(paste("BEAST2 jar not found at path '",beast_jar_path,"'",sep=""))
  }
  assert(file.exists(beast_jar_path) || file.exists(beast_bin_path))
  
  # Create a BEAST2 XML input file
  convert_alignment_to_beast_input_file(
    alignment_dnabin = alignment_dnabin,
    mcmc_chainlength = mcmc_chainlength,
    rng_seed = rng_seed,
    beast_filename = beast_filename,
    temp_fasta_filename = temp_fasta_filename
  )
  assert(file.exists(beast_filename))
  
  # Run BEAST2, needs the BEAST2 .XML parameter file
  # Prevent BEAST prompting the user whether to overwrite the log file
  assert(!file.exists(beast_trees_filename)) #DEBUG
  assert(!file.exists(beast_log_filename)) #DEBUG
  assert(!file.exists(beast_state_filename)) #DEBUG

  if (file.exists(beast_trees_filename)) { 
    file.remove(beast_trees_filename)
    print(paste("NOTE: removed '",beast_trees_filename,"'"), sep="")
  }
  if (file.exists(beast_log_filename)) { 
    file.remove(beast_log_filename) 
    print(paste("NOTE: removed '",beast_log_filename,"'"), sep="")
  }
  if (file.exists(beast_state_filename)) { 
    file.remove(beast_state_filename) 
    print(paste("NOTE: removed '",beast_state_filename,"'"), sep="")
  }
  assert(!file.exists(beast_trees_filename))
  assert(!file.exists(beast_log_filename))
  assert(!file.exists(beast_state_filename))

  print(paste("NOTE: no '",beast_trees_filename,"'"), sep="")
  print(paste("NOTE: no '",beast_log_filename,"'"), sep="")
  print(paste("NOTE: no '",beast_state_filename,"'"), sep="")
  
  
  # Call BEAST2 binary file directly
  if (file.exists(beast_bin_path))
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
    if (file.exists(beast_trees_filename)) {
      print("File created by beast binary")
    }
  }

  
  # Call BEAST2 jar
  if (!file.exists(beast_trees_filename)) {
    if (file.exists(beast_jar_path)) {
      cmd <- paste(
        "java -jar ", beast_jar_path, 
        " -seed ", rng_seed,
        " ", beast_filename,
        sep = ""
      )
      system(cmd)
    }
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
  assert(is_beast_posterior(posterior))
  return (posterior)
}  

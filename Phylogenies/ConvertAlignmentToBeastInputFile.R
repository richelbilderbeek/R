# Convert an alignment and parameters to a BEAST XML input file

library(ape)
library(geiger)
library(PBD)
library(phangorn)
library(testit)
source("~/GitHubs/R/FileIo/FilesAreEqual.R")
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignment.R")
source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")
source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentToFasta.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
source("~/GitHubs/BeastScripter/BeastScripter.R")

get_beast_scripter_exe_path <- function() {
  return ("~/Programs/BeastScripter/BeastScripterConsole")
}


convert_alignment_to_beast_input_file_using_cpp_executable <- function(
  alignment_dnabin,
  mcmc_chainlength,
  rng_seed = 42,
  beast_filename
) {
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file
  # using the C++ executable of BeastScripter

  # File paths for BeastScripter
  beast_scripter_path <- get_beast_scripter_exe_path()
  base_filename <- "test_output_1"
  fasta_filename <- paste(base_filename,".fasta",sep="");
  
  if (!file.exists(beast_scripter_path))
  {
    print(paste("BeastScripter not found at path '",beast_scripter_path,"'",sep=""))
    stop()
  }
  assert(file.exists(beast_scripter_path))

  # Save to FASTA file
  convert_alignment_to_fasta(alignment_dnabin,fasta_filename)

  options(scipen = 20) # So that mcmc_chainlength is written as 1000000 instead of 1e+7
  
  # Create BEAST2 parameter file from FASTA file and parameters
  cmd <- paste(
    beast_scripter_path, 
    " --fasta ",fasta_filename,
    " --mcmc_length ",mcmc_chainlength,
    " --tree_prior ","birth_death",
    " --output_file ",beast_filename,
    sep=""
  )
  print(paste("ConvertAlignmentToBeastPosterior: Executing command: ",cmd,sep=""))
  system(cmd)
  assert(file.exists(beast_filename))
}  


convert_alignment_to_beast_input_file_using_r_script <- function(
  alignment_dnabin,
  mcmc_chainlength,
  rng_seed = 42,
  beast_filename
) {
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file
  # using the R script version of BeastScripter
  
  # Save to FASTA file
  fasta_filename <- "test_output_1.fasta"
  convert_alignment_to_fasta(alignment_dnabin,fasta_filename)

  options(scipen = 20) # So that mcmc_chainlength is written as 1000000 instead of 1e+7

  BeastScripter(
    input_fasta_filename = fasta_filename,
    mcmc_chainlength = mcmc_chainlength,
    tree_prior = "birth_death",
    date_str = "20151027",
    output_xml_filename = beast_filename
  )

  assert(file.exists(beast_filename))
}  


# Reads an alignment (a FASTA file) and with some
# additional parameters create a BEAST2 XML input file
convert_alignment_to_beast_input_file <- function(
  alignment_dnabin,
  mcmc_chainlength,
  rng_seed = 42,
  beast_filename
) {
  # Choose the fastest, iff present
  if (file.exists(get_beast_scripter_exe_path())) {
    convert_alignment_to_beast_input_file_using_cpp_executable(
      alignment_dnabin = alignment_dnabin,
      mcmc_chainlength = mcmc_chainlength,
      rng_seed = rng_seed,
      beast_filename = beast_filename
    )
  } else {
    convert_alignment_to_beast_input_file_using_r_script(
      alignment_dnabin = alignment_dnabin,
      mcmc_chainlength = mcmc_chainlength,
      rng_seed = rng_seed,
      beast_filename = beast_filename
    )
  }
}

demonstrate_convert_alignment_to_beast_inputFile <- function() {

  phylogeny_without_outgroup <- create_random_phylogeny(n_taxa = 5)

  phylogeny_with_outgroup <- add_outgroup_to_phylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )
  image(alignment)
  beast_xml_input_file_using_cpp_exe  <- "temp_using_cpp_exe.xml"
  beast_xml_input_file_using_r_script <- "temp_using_r_script.xml"
  
  convert_alignment_to_beast_input_file_using_cpp_executable(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_xml_input_file_using_cpp_exe
  )
  assert(file.exists(beast_xml_input_file_using_cpp_exe))

  convert_alignment_to_beast_input_file_using_r_script(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_xml_input_file_using_r_script
  )
  assert(file.exists(beast_xml_input_file_using_r_script))
  
  assert(
    files_are_equal(
      beast_xml_input_file_using_cpp_exe,
      beast_xml_input_file_using_r_script
    )
  )

  # Can print either as they are identical
  print(readLines(beast_xml_input_file_using_r_script))

  # Clean up: remove the temporary files
  file.remove(beast_xml_input_file_using_cpp_exe)
  file.remove(beast_xml_input_file_using_r_script)
  assert(!file.exists(beast_xml_input_file_using_cpp_exe))
  assert(!file.exists(beast_xml_input_file_using_r_script))
}

# Uncomment this to view the function demonstration
#demonstrate_convert_alignment_to_beast_inputFile()

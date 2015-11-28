# Convert an alignment and parameters to a BEAST XML input file
# using the BeastScripter C++ executable

source("~/GitHubs/R/Phylogenies/convert_alignment_to_fasta.R")



get_beast_scripter_exe_path <- function() {
  return ("~/Programs/BeastScripter/BeastScripterConsole")
}



convert_alignment_to_beast_input_file_using_cpp_executable <- function(
  alignment_dnabin,
  mcmc_chainlength,
  beast_filename,
  rng_seed = 42,
  temp_fasta_filename = tempfile(pattern = "convert_alignment_to_beast_input_file_using_cpp_executable", fileext = ".fasta")
) {
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file
  # using the C++ executable of BeastScripter

  # File paths for BeastScripter
  beast_scripter_path <- get_beast_scripter_exe_path()

  if (!file.exists(beast_scripter_path))
  {
    print(paste("BeastScripter not found at path '", beast_scripter_path, "'", sep=""))
    stop()
  }
  assert(file.exists(beast_scripter_path))

  # Save to FASTA file
  convert_alignment_to_fasta(
    alignment_dnabin,
    temp_fasta_filename
  )

  options(scipen = 20) # So that mcmc_chainlength is written as 1000000 instead of 1e+7
  
  # Create BEAST2 parameter file from FASTA file and parameters
  cmd <- paste(
    beast_scripter_path, 
    " --fasta ", temp_fasta_filename,
    " --mcmc_length ", mcmc_chainlength,
    " --tree_prior ", "birth_death",
    " --output_file ", beast_filename,
    sep=""
  )
  print(paste("convert_alignment_to_beast_input_file_using_cpp_executable: Executing command: ", cmd, sep=""))
  system(cmd)
  assert(file.exists(beast_filename))
}
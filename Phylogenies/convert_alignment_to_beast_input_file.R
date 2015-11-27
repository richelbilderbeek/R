# Convert an alignment and parameters to a BEAST XML input file

source("~/GitHubs/R/Phylogenies/convert_alignment_to_beast_input_file_using_cpp_executable.R")
source("~/GitHubs/R/Phylogenies/convert_alignment_to_beast_input_file_using_r_script.R")

convert_alignment_to_beast_input_file <- function(
  alignment_dnabin,
  mcmc_chainlength,
  rng_seed = 42,
  beast_filename
) {
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file

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
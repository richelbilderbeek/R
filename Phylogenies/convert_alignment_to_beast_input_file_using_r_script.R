# Convert an alignment and parameters to a BEAST XML input file
# using the R script version of BeastScripter

source("~/GitHubs/R/Phylogenies/convert_alignment_to_fasta.R")
source("~/GitHubs/BeastScripter/BeastScripter.R")

convert_alignment_to_beast_input_file_using_r_script <- function(
  alignment_dnabin,
  mcmc_chainlength,
  beast_filename,
  rng_seed = 42,
  temp_fasta_filename
) {
  # Reads an alignment (a FASTA file) and with some
  # additional parameters create a BEAST2 XML input file
  # using the R script version of BeastScripter
  
  # Save to FASTA file
  convert_alignment_to_fasta(alignment_dnabin, temp_fasta_filename)

  options(scipen = 20) # So that mcmc_chainlength is written as 1000000 instead of 1e+7

  beast_scripter(
    input_fasta_filename = temp_fasta_filename,
    mcmc_chainlength = mcmc_chainlength,
    tree_prior = "birth_death",
    date_str = "20151027",
    output_xml_filename = beast_filename
  )

  assert(file.exists(beast_filename))
  file.remove(temp_fasta_filename)
  assert(!file.exists(temp_fasta_filename))
} 
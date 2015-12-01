# Convert an alignment and parameters to a BEAST XML input file

source("~/GitHubs/R/Phylogenies/create_random_phylogeny.R")
source("~/GitHubs/R/Phylogenies/add_outgroup_to_phylogeny.R")
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")
source("~/GitHubs/R/Phylogenies/convert_alignment_to_beast_input_file.R")
source("~/GitHubs/R/FileIo/files_are_equal.R")

convert_alignment_to_beast_input_file_test <- function() {

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
  
  
  temp_fasta_filename <- "demonstrate_convert_alignment_to_beast_input_file.fasta"
  print(paste("Using temporary FASTA filename '",temp_fasta_filename,"'", sep=""))
  convert_alignment_to_beast_input_file_using_cpp_executable(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_xml_input_file_using_cpp_exe,
    temp_fasta_filename = temp_fasta_filename
  )
  assert(file.exists(beast_xml_input_file_using_cpp_exe))

  convert_alignment_to_beast_input_file_using_r_script(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_xml_input_file_using_r_script,
    temp_fasta_filename = temp_fasta_filename
  )
  assert(file.exists(beast_xml_input_file_using_r_script))

  if (!files_are_equal(beast_xml_input_file_using_cpp_exe,beast_xml_input_file_using_r_script)) {
    print(paste("ERROR: Files '",beast_xml_input_file_using_cpp_exe,"' and '",beast_xml_input_file_using_r_script,"' are different", sep=""))
  }
    
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

convert_alignment_to_beast_input_file_test()

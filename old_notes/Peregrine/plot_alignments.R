library(testit)
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/read_file.R")

plot_alignments <- function(filename) {
  assert(is_valid_file(filename))
  base_filename <- get_base_filename(filename)
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  for (i in seq(1,n_species_trees_samples)) {
    for (j in seq(1,n_alignments)) {
      alignment_index <- 1 + j - 1 + ((i - 1) * n_species_trees_samples)
      assert(alignment_index >= 1)
      assert(alignment_index <= length(file$alignments))
      png(paste(base_filename,"_alignment_",i,"_",j,".png",sep=""))
      image(file$alignments[[alignment_index]][[1]], main=paste(base_filename,"alignment",i,j))
      dev.off()
    }
  }
}
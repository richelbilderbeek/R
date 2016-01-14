library(testit)
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")

plot_posterior_average_nltts <- function(filename) {
  assert(is_valid_file(filename))
  base_filename <- get_base_filename(filename)
  file <- read_file(filename)
  n_species_trees_samples <- as.numeric(file$parameters$n_species_trees_samples[2])
  n_alignments <- as.numeric(file$parameters$n_alignments[2])
  n_beast_runs <- as.numeric(file$parameters$n_beast_runs[2])
  for (i in seq(1,n_species_trees_samples)) {
    for (j in seq(1,n_alignments)) {
      for (k in seq(1,n_beast_runs)) {
        trees_filename <- paste(base_filename,"_",i,"_",j,"_",k,".trees",sep="")
        all_trees <- beast2out.read.trees(trees_filename)
        png(paste(base_filename,"_posterior_average_nltt_",i,"_",j,"_",k,".png",sep=""))
        get_average_nltt(all_trees,replot = FALSE,lty=3,lwd = 2, main=paste(base_filename," posterior average nLTT"))
        get_average_nltt(
          list(file$species_trees_with_outgroup[[1]][[1]],
          file$species_trees_with_outgroup[[1]][[1]]),
          replot = TRUE,lty=1,lwd = 2)
        dev.off()
      }
    }
  }
}
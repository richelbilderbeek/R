library(testit)
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
plot_posterior_sample_nltts <- function(filename) {
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
        last_tree <- tail(all_trees,n=1)[[1]]
        png(paste(base_filename,"_posterior_sample_nltt_",i,"_",j,"_",k,".png",sep=""))
        nLTT.plot(file$species_trees_with_outgroup[[1]][[1]],
          main=paste(base_filename,"species tree with outgroup nLTTs",i,j,k), lwd = 2
        )
        nLTT.lines(last_tree, lwd = 2, lty = 3)
        dev.off()
      }
    }
  }
}
library(nLTT)
library(testit)
source("~/GitHubs/R/Peregrine/is_valid_file.R")
source("~/GitHubs/R/FileIo/get_base_filename.R")
source("~/GitHubs/R/Peregrine/read_file.R")
source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")

plot_posterior_nltts_stats_histogram <- function(filename) {
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
        all_nltt_stats <- NULL
        for (tree in all_trees) {
          all_nltt_stats <- c(all_nltt_stats,nLTTstat(file$species_trees_with_outgroup[[1]][[1]],tree))
        }
        png(paste(base_filename,"_nltts_stats_",i,"_",j,"_",k,".png",sep=""))
        hist(all_nltt_stats,xlim=c(0,0.12),main=paste(base_filename," distribution of nLTT statistics\nbetween species tree and posterior",i,j,k))
        dev.off()
      }
    }
  }
}
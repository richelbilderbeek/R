do_analyze_posterior_samples <- function(filename) {
  assert(file.exists(filename))
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
        
        png(paste(base_filename,"_posterior_sample_",i,"_",j,"_",k,".png",sep=""))
        plot(last_tree,main=paste(base_filename,"last tree in posterior",i,j,k))
        dev.off()
      }
    }
  }
}
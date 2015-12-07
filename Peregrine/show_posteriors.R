source("~/GitHubs/R/Peregrine/read_libraries.R")
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
read_libraries()

show_posteriors <- function(filename)
{
  file <- read_file(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'alignments' this has already been done
  if(is.null(file$posteriors)) {
    print(paste("file ",filename," does not contain posteriors",sep=""))
    return ()
  }
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$alignments))
  assert(!is.null(file$posteriors))

  assert(mode(file) == "list")
  gene_tree <- file$pbd_output$tree
  species_trees_with_outgroup <- file$species_trees_with_outgroup
  posteriors <- file$posteriors
  

  assert(length(posteriors) > 0)

  # Extract phylogenies from posterior
  phylogenies <- NULL
  for (posterior in posteriors) {
    phylogenies <- c(phylogenies,list(posterior[[1]]))
  }
  
  get_average_nltt(species_trees_with_outgroup,plot_nltts = TRUE, main = "Recovery (black) versus original (red)")
  nLTT.lines(gene_tree, col = "red")
  

  for (posterior in posteriors) {
    # Compare nLTT distribution
    all_nltt_stats <- NULL
    for (tree in posterior)
    {
      all_nltt_stats = c(all_nltt_stats,nLTTstat(gene_tree,tree))
    }
    
    hist(all_nltt_stats)
  
    # Plot the original and last of the posterior's tree
    n_cols <- 1
    n_rows <- 2
    par(mfrow=c(n_rows,n_cols))
    plot(gene_tree,main="Truth")
    add.scale.bar()
    plot(tail(phylogenies,n=1)[[1]],main="Inferred")
    add.scale.bar()
    par(mfrow=c(1,1))
  }
}




#rm(list = ls())
source("~/GitHubs/R/Peregrine/read_libraries.R")
ReadLibraries()

ShowPosteriors <- function(filename)
{
  file <- ReadFile(filename)
  assert(mode(file) == "list")
  
  # If it already contains 'alignments' this has already been done
  if(is.null(file$posteriors)) {
    print(paste("file ",filename," does not contain posteriors",sep=""))
    return ()
  }

  print(paste("Adding result to file ",filename,sep=""))
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(!is.null(file$alignments))
  assert(!is.null(file$posteriors))

  phylogeny_with_outgroup <- file$phylogeny_with_outgroup
  posteriors <- file$posteriors
  
  assert(mode(file) == "list")

  assert(length(posteriors) > 0)

  # Extract phylogenies from posterior
  phylogenies <- NULL
  for (posterior in posteriors) {
    phylogenies <- c(phylogenies,list(posterior[[1]]))
  }
  GetAverageNltt(phylogenies,plot_nltts = TRUE, main = "Recovery (black) versus original (red)")
  nLTT.lines(phylogeny_with_outgroup, col = "red")
  
  results <- 
?recordPlot
  for (posterior in posteriors) {
    # Compare nLTT distribution
    all_nltt_stats <- NULL
    for (tree in posterior)
    {
      all_nltt_stats = c(all_nltt_stats,nLTTstat(phylogeny_with_outgroup,tree))
    }
    
    hist(all_nltt_stats)
  
    # Plot the original and last of the posterior's tree
    n_cols <- 1
    n_rows <- 2
    par(mfrow=c(n_rows,n_cols))
    plot(phylogeny_with_outgroup,main="Truth")
    add.scale.bar()
    plot(last_tree,main="Inferred")
    add.scale.bar()
    par(mfrow=c(1,1))
  }

  # Save the file
  saveRDS(file,file=filename)

  file_again <- readRDS(filename)
  assert(all.equal(file_again$results,results))
  assert(!is.null(file$results))
  
  print(paste("file ",filename," has gotten its results",sep=""))
}




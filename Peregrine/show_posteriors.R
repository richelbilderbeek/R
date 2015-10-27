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
  
  assert(!is.null(file$parameters))
  assert(!is.null(file$phylogeny_with_outgroup))
  assert(!is.null(file$alignments))
  assert(!is.null(file$posteriors))

  phylogeny_with_outgroup <- file$phylogeny_with_outgroup
  posteriors <- file$posteriors
  
  assert(mode(file) == "list")

  assert(length(posteriors) > 0)

  for (posterior in posteriors) {
    last_tree <- tail(posterior,n=1)[[1]]
    
    # Plot last tree
    plot(last_tree,main="Last tree in posterior")
    
  
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
}




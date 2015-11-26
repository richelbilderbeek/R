source("~/GitHubs/R/Phylogenies/get_average_nltt.R")

demonstrate_get_average_nltt <- function()
{
  # Two different phylogenies
  newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny1 <- read.tree(text = newick1)
  
  newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phylogeny2 <- read.tree(text = newick2)

  plot(phylogeny1)
  plot(phylogeny2)
  nLTT.plot(phylogeny1)
  nLTT.lines(phylogeny2,col = "gray")
  
  # Combine these at different resolutions
  phylogenies <- list(phylogeny1,phylogeny2)
  for (dt in c(0.2,0.05,0.01)) {
    get_average_nltt(phylogenies,dt = dt,main=paste("dt:",dt))
    nLTT.lines(phylogeny1,col="red")
    nLTT.lines(phylogeny2,col="blue")
  }
  
  
  # Now random trees
  phylogenies <- NULL
  for (i in seq(1,100)) {
    phylogeny <- rcoal(n = 10)
    phylogenies <- c(phylogenies,list(phylogeny))
  }
  
  get_average_nltt(
    phylogenies,
    plot_nltts = TRUE,
    main = "Average LTT of 100 coalescent trees"
    
  )
}

demonstrate_get_average_nltt()

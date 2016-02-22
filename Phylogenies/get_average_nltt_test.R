#rm(list = ls())
source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
library(ape)
library(nLTT)
library(TreeSim)

get_average_nltt_test <- function()
{
  # Two different phylogenies
  newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny1 <- read.tree(text = newick1)
  nLTT.plot(
    phylogeny
  )
  nLTT.lines(
    phylogeny
  )
  
  newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phylogeny2 <- read.tree(text = newick2)

  plot(phylogeny1)
  plot(phylogeny2)
  nLTT.plot(phylogeny1)
  nLTT.lines(phylogeny2,col = "gray")
  
  # Combine these at different resolutions
-  phylogenies <- list(phylogeny1,phylogeny2)
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
    main = "Average nLTT of 100 coalescent trees"
    
  )
  get_average_nltt_new(
    phylogenies,
    plot_nltts = FALSE,
    main = "Average nLTT of 100 coalescent trees (new)"
  )
  get_average_nltt_new(
    phylogenies,
    plot_nltts = TRUE,
    main = "Average nLTT of 100 coalescent trees (new)"
  )
}

get_average_nltt_test()

newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
phylogeny1 <- read.tree(text = newick1)
phylogeny1_rescaled <- rescale(phylogeny1, model = "depth", depth = 1.0)
newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
phylogeny2 <- read.tree(text = newick2)
phylogenies <- c(phylogeny1,phylogeny2)
#for (i in seq(1,length(phylogenies)))
#{
#  phylogenies[[i]] <- rescale(phylogenies[[i]], model = "depth", depth = 1.0)
#}
plot(phylogenies[[1]])
add.scale.bar()
nLTT.plot(phylogenies[[1]])
plot(phylogenies[[2]])
add.scale.bar()
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.general.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.average.root.R")

# Plot first phylogeny
t <- ltt.plot.coords(phylogenies[[1]])
t
crown_age <- -t[1,1]
crown_age
t[,1] <- (t[,1] / crown_age) + 1
t
n_lineages <- t[nrow(t),2]
t[,2] <- t[,2] / n_lineages
t
plot(t, type='l',col='black',xlab="time",ylab="number of species")
class(t)
LTT.plot.gen(phylogenies[[1]])
plot(
  LTT.average.root(phylogenies) + 1,
  type='l',col='black',xlab="time",ylab="number of species"
)

#Correct range
r <- LTT.average.root(phylogenies)
class(r)
r[,1] <- r[,1]+1
r[,2]
r

nLTT.lines
nLTT.lines(phy = phylogenies[[1]])
library(nLTT)
??LTT.average.root
nLTT.lines


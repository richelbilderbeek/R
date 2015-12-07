library(ape)

get_phylogeny_nltt_matrix <- function(phylogeny) {
  # Obtain the matrix from an nLTT plot
  
  xy <- ltt.plot.coords(phylogeny, backward = TRUE, tol = 1e-06)
  xy[, 2] <- xy[, 2]/max(xy[, 2])
  xy[, 1] <- xy[, 1] + abs(min(xy[, 1]))
  xy[, 1] <- xy[, 1]/max(xy[, 1])
  return (xy)
}

GetPhylogenyNlttMatrix <- function(phylogeny) {
  print(paste("Warning: use of obsolete function 'GetPhylogenyNlttMatrix', use 'get_phylogeny_nltt_matrix' instead", sep=""))
  return (get_phylogeny_nltt_matrix(phylogeny))
}
source("~/GitHubs/R/Phylogenies/get_phylogeny_nltt_matrix.R")
source("~/GitHubs/R/Phylogenies/stretch_nltt_matrix.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.general.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.average.root.R")

library(ape)
library(geiger)
library(nLTT)
library(testit)

get_average_nltt <- function(
  phylogenies, 
  dt = 0.001,
  plot_nltts = FALSE,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  replot = FALSE,
  ...
) {
  #  phylogenies, 
  #  dt: delta t, resolution of the averaged nLTT, where smaller is a higher resolution
  #  plot_nltts = FALSE,
  #  xlab: label on x axis
  #  ylab: label on y axis
  #  replot: if FALSE, a new plot is started, if TRUE, the lines is drawn over an assumed-to-be-present plot
  #  ...
  assert(dt > 0.0)
  assert(dt < 1.0)
  
  sz <- length(phylogenies)

  nltts <- NULL
  for (phylogeny in phylogenies) {
    nltts <- c(nltts,list(get_phylogeny_nltt_matrix(phylogeny)))
  }
  assert(length(nltts) == length(phylogenies))

  stretch_matrices <- NULL
  for (nltt in nltts) {
    stretch_matrix <- stretch_nltt_matrix(nltt,dt = dt)
    stretch_matrices <- c(stretch_matrices,list(stretch_matrix))
  }
  assert(length(stretch_matrices) == length(nltts))
  
  xy <- stretch_matrices[[1]]
  for (i in seq(2,sz)) {
    xy <- (xy + stretch_matrices[[i]])
  }
  xy <- (xy / sz)
  
  # Set the shape of the plot
  if (replot == FALSE) {
    plot.default(
      xy, 
      xlab = "Normalized Time", 
      ylab = "Normalized Lineages", 
      xaxs = "r", 
      yaxs = "r", 
      type = "S",
      xlim=c(0,1),
      ylim=c(0,1),
      ...
    )
  }
  
  # Draw the nLTTS plots used
  if (plot_nltts == TRUE) {
    for (stretch_matrix in stretch_matrices) {
      lines.default(
        stretch_matrix,
        xaxs = "r", 
        yaxs = "r", 
        type = "S",
        col="grey",
        xlim=c(0,1),
        ylim=c(0,1)
      )
    }
  }  

  # Redraw the average nLTT plot
  lines.default(
    xy,
    xaxs = "r", 
    yaxs = "r", 
    type = "S",
    xlim=c(0,1),
    ylim=c(0,1),
    ...
  )
}

get_average_nltt_new <- function(
  phylogenies, 
  plot_nltts = FALSE,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  replot = FALSE,
  ...
) {
  #  phylogenies, 
  #  dt: delta t, resolution of the averaged nLTT, where smaller is a higher resolution
  #  plot_nltts = FALSE,
  #  xlab: label on x axis
  #  ylab: label on y axis
  #  replot: if FALSE, a new plot is started, if TRUE, the lines is drawn over an assumed-to-be-present plot
  #  ...
  for (i in seq(1,2))
  {
    phylogenies[[i]] <- rescale(phylogenies[[i]], model = "depth", depth = 1.0)
  }

  # Set the shape of the plot
  if (replot == FALSE) {
    plot(
      LTT.average.root(phylogenies),
      type='l',
      col='black',
      xlab = "Normalized Time", 
      ylab = "Normalized Lineages"
    )
  }
  
  # Draw the nLTTS plots used
  if (plot_nltts == TRUE) {
    lines.default(
      LTT.average.root(phylogenies),
      type='l',
      col="grey"
    )
  }  
  
  # Redraw the average nLTT plot
  lines.default(
    LTT.average.root(phylogenies),
    type='l',
    col='black'
  )
}
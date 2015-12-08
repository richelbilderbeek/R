source("~/GitHubs/R/Plot/plot_ltt.R")

plot_ltt_test <- function() {
  phylogeny <- rcoal(10)
  plot_ltt(phylogeny, main = "plot_ltt_test")
}

plot_ltt_test()
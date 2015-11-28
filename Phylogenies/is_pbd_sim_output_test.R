library(PBD)
library(testit)

source("~/GitHubs/R/Phylogenies/is_pbd_sim_output.R")

# Does not use pbd_sim()$stree, but generates these like PBD does
is_pbd_sim_output_test <- function() {
  assert(is_pbd_sim_output(pbd_sim(c(0.2,1,0.2,0.1,0.1),15)))
  assert(!is_pbd_sim_output(rep(x = 0, times = 9)))
  assert(!is_pbd_sim_output(as.list(rep(x = 0, times = 9))))
  print("is_pbd_sim_output: OK")
}

is_pbd_sim_output_test()
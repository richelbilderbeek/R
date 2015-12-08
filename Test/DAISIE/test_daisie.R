rm(list = ls())
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_dataprep.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_ExpEIN.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_format_sim.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_loglik_all.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_loglik_high_lambda.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_ML.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_PEI.R")
#source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_plot_sims.R")
source("~/GitHubs/R/Plot/plot_average_ltt_and_quartiles.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_sim_core.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_sim_min_type2.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_sim.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_tutorial.R")
source("~/GitHubs/R/MyFavoritePackages/DAISIE/R/DAISIE_utils.R")

data(islands_10reps_RAW)
island_replicates <- DAISIE_format_sim(
  island_replicates = islands_10reps_RAW,
  time = 4,
  M = 100,
  sample_freq = 25
)

assert(class(island_replicates) == "list")
assert(class(island_replicates[[1]]) == "list")
assert(class(island_replicates[[1]][[1]]) == "list")
assert(names(island_replicates[[1]][[1]]) == c("island_age","not_present","stt_all"))
assert(class(island_replicates[[1]][[1]]$stt_all) == "matrix")
assert(is.null(names(island_replicates[[1]][[1]]$stt_all)))
assert(colnames(island_replicates[[1]][[1]]$stt_all) == c("Time", "nI", "nA", "nC", "present"))
island_replicates[[1]][[1]]$stt_all
island_replicates[[2]][[1]]$stt_all


#DAISIE_plot_sims(island_replicates)
plot_average_ltt_and_quartiles(island_replicates)

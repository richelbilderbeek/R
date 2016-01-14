source("~/GitHubs/R/Peregrine/read_libraries.R")


CollectResultFiles <- function() {
  result_files <- list.files(
    path = ".", 
    pattern = "_results.txt",
  )
}

ReadResult <- function(result_filename)
{
  assert(file.exists(result_filename))
  result <- readRDS(result_filename)
}

CollectResults <- function() {
  results <- NULL
  for (result_filename in CollectResultFiles()) {
    results <- c(results,ReadResult(result_filename))  
  }
  return (results)
}


ReadLibraries()



phylogeny_with_outgroup <- results$phylogeny_with_outgroup
all_trees <- results$posterior


last_tree <- tail(all_trees,n=1)[[1]]
plot(last_tree,main="Last tree in posterior")

all_nltt_stats <- NULL
for (tree in all_trees)
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
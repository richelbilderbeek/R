library(ape)

get_most_recent_common_ancestor_of_two_tips <- function(phylogeny, tip1, tip2) {
  # Returns a node index
  
  return (getMRCA(phylogeny, tip = c(tip1,tip2)))
}
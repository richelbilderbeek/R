is_phylogeny <- function(x) {
  # Is x a single phylogeny?
  return (class(x) == "phylo")
}
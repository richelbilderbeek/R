# Does not use pbd_sim()$stree, but generates these like PBD does
is_pbd_sim_output <- function(
  pbd_sim_output
) {
  if (typeof(pbd_sim_output) != "list") return (FALSE)
  if (length(pbd_sim_output) != 9) return (FALSE)
  if (class(pbd_sim_output$tree) != "phylo") return (FALSE)
  return (TRUE)
}
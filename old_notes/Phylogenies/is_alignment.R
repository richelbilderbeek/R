is_alignment <- function(x) {
  # Is x a single alignment?
  
  return (class(x) == "DNAbin")
}
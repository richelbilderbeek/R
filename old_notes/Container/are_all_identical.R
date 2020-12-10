are_all_identical <- function(container) 
{
  # Determines if all elements in a container are identical
  
  return (length(unique(container)) == 1)
}
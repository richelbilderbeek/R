are_all_unique <- function(container)  {
  # Determines if all elements in a container are unique
  
  return (length(container) == length(unique(container)))
}
is_string <- function(s) {
  # Checks if s is a single string
  
  if (length(s) > 1) return (FALSE)
  return (is.character(s))
}



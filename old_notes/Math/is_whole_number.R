is_whole_number <- function(
  x, 
  tolerance = .Machine$double.eps^0.5
) {
  # Checks if x is a single, whole-number variable
  # x: the number to check
  # tolerance: the maximum error a number may deviate from a whole number,
  #   before it is labeled as a floating point value
  
  if (length(x) > 1) return (FALSE)
  if (!is.numeric(x)) return (FALSE)
  return (abs(x - round(x)) < tolerance)
}
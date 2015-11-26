# Stretch matrix 'm' with a timestep resolution of 'dt'

stretch_nltt_matrix <- function(
  m,
  dt
) {
  # Stretch matrix 'm' with a timestep resolution of 'dt'
  
  # Fill in the timepoints:
  #
  # t   N
  # 0.0 0.2
  # 0.4 0.5
  # 1.0 1.0
  #
  # becomes
  #
  # t   N
  # 0.0 0.2
  # 0.1 0.2
  # 0.2 0.2
  # 0.3 0.2
  # 0.4 0.5
  # 0.5 0.5
  # 0.6 0.5
  # 0.7 0.5
  # 0.8 0.5
  # 0.9 0.5
  # 1.0 1.0
  #
  # I need to reverse the timepoints
  
  
  # If the matrix has multiple Ns for the same t, take the lowest 
  m<-aggregate(
    x=m,
    by=list(factor(m[,1])),
    FUN="min"
  )

  # Create vectors, mirror the ts
  #
  # The ts must be mirrored, 
  # because from the points indicated by an asterisk,
  # the 'equals sign line' must be generated,
  # where approx will produce the dotted line
  #
  # |
  # |               +=========*
  # |               |         .
  # |   +===========*..........
  # |   |           .
  # |   *............
  # |
  # +--------------------------
  #
  ns <- as.numeric(m[,3]) # N
  ts <- 1.0 - as.numeric(m[,2]) # t
  
  a <- approx(ts, ns, method = "constant", n = 1 / dt)

  # Mirror the ts again
  new_ts <- 1.0 - a$x
  new_ns <- a$y
  assert(length(new_ts) == length(new_ns))
  n <- matrix(
    data = c(new_ts,new_ns),
    nrow = length(new_ts),
    ncol = 2,
    byrow = FALSE,
  )
  return (n)
}
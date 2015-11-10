
DemonstrateApprox <- function() {
  x <- 1:10
  y <- rnorm(10)
  plot(x, y, main = "approx(.) and approxfun(.)")
  points(approx(x, y), col = 2, pch = "*")
  points(approx(x, y, method = "constant"), col = 4, pch = "*")

  x <- 1:10
  y <- 1:10
  a <- approx(x, y, method = "constant")
  names(a)
}

DemonstrateApprox()
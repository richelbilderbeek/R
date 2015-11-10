
DemonstrateApprox <- function() {
  x <- 1:10
  y <- rnorm(10)
  plot(x, y, main = "approx(.) and approxfun(.)")
  points(approx(x, y), col = 2, pch = "*")
  points(approx(x, y, method = "constant"), col = 4, pch = "*")
  ?approx
  x <- 1:10
  y <- 1:10
  a <- approx(x, y, method = "constant", n = 1000)
  names(a)
  a
  new_x <- a$x
  new_y <- a$y
}

DemonstrateApprox()
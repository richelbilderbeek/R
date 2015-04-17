library(testit)
library(vegan)


size <- 100

xs <- rep(0,size)
ys <- rep(0,size)

for (i in seq(0,size))
{
  p1 <- i / size
  p2 <- 1.0 - p1
  x <- c(p1,p2)
  assert("Sum of relative population densities must be one",abs(sum(x)-1.0) < 0.00001)
  shannon_diversity_index <- diversity(x, index = "shannon", MARGIN = 1, base = exp(1))
  
  xs[i + 1] <- p1
  ys[i + 1] <- shannon_diversity_index
  
}

plot(
  xs,ys,
  main="Shannon's H index of a two-species population",
  xlab="Species 1 density (=1.0 - Species 2 density)",
  ylab="Shannon's H index",
  type='line'
)
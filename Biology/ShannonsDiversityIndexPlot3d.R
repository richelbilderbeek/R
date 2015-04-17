library(testit)
library(vegan)
library(fields)
library(rgl)
library(akima)


size <- 100

t <- matrix(0.0,size*size,3)

for (i in seq(1,size*size))
{
  x <- i / size
  y <- i %% size
  p1 <- x / size
  p2 <- y / size
  p3 <- 1.0 - p1 - p2
  if (p3 < 0) next
  pop_fractions <- c(p1,p2,p3)
  assert("Sum of relative population densities must be one",abs(sum(pop_fractions)-1.0) < 0.00001)
  shannon_diversity_index <- diversity(pop_fractions, index = "shannon", MARGIN = 1, base = exp(1))
  
  t[i,1] <- x
  t[i,2] <- y
  t[i,3] <- shannon_diversity_index  

}

plot3d(t,xlab="Fraction of population being species 1",ylab="Fraction of population being species 2",zlab="Shannon's H index")

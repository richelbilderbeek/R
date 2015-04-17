library(testit)
library(vegan)

x <- c(1/3,1/3,1/3)
assert("Sum of relative population densities must be one",abs(sum(x)-1.0) < 0.00001)

shannon_diversity_index <- diversity(x, index = "shannon", MARGIN = 1, base = exp(1))

print(shannon_diversity_index)
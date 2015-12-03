# Demonstration how to print the number 1000000000 as '1000000000'
# instead of '1e+09'

billion <- 1000000000
print(billion)
options(scipen = 20)
print(billion)

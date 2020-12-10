library(testit)

filename <- "myfunction.R"
f <- NULL

# There will be three functions
# 1) f(t) = 2 * t
# 2) f(t) = a * t
# 3) f(t) = K * (1 / (1 + a * exp(-b*t)))


# User input: use which function?
function_index <- 2

# For model 2, a needs to have a value
a <- 42

# Write a function to file, call 
if (function_index == 1) {
  my_file <- file(filename)
  writeLines(
    c(
      "f <- function(t) {",
      "  return (t * 2)",
      "}"
    ), 
    my_file
  )
  close(my_file)
} else if (function_index == 2) {
  my_file <- file(filename)
  writeLines(
    c(
      "f <- function(t) {",
      "  return (t * ",a,")",
      "}"
    ), 
    my_file
  )
  close(my_file)
}

# Import that file
source(filename)

# Note: now f should be known

# Call that file its function
assert(f(2) == a * 2)


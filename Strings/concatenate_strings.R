# Demonstration how to concatenate strings, using paste

my_value <- 42
my_str_1 <- paste(c("My favorite value is ", my_value), collapse = "")
my_str_2 <- paste("My favorite value is ", my_value, sep = "")
# my_str_3 <- cat("My favorite value is ", my_value, sep = "") # DON'T! cat only prints the values, without returning anything
assert(my_str_1 == my_str_2)
print(my_str_1)


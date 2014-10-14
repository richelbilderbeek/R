# Clear the working memory
rm(list = ls())

a <- c(1,2,3,4,5);
b <- c(1,2,3,4,5);
c <- c(1,2,3,3,4);
d <- c(0,0,0,0,0);


# c <- a + b
# print(a)
# print(b)
# print(c)

my_table <- data.frame(cbind(a,b,c))
print(my_table)

my_table$d <- my_table$a + my_table$b
my_table$d <- my_table$d + my_table$c
print(my_table)

# Cause error: + not meaningful for factors
my_table$d = as.factor(c(6,7,8,9,10)) #Even not when all numbers 
my_table$d <- my_table$d + my_table$c

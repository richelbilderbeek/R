# Sum two columns, overwriting an existing one

```
# Clear the working memory
rm(list = ls())

a <- c(1,2,3,4,5);
b <- c(1,2,3,4,5);
c <- c(0,0,0,0,0);


# c <- a + b
# print(a)
# print(b)
# print(c)

my_table <- data.frame(cbind(a,b,c))
print(my_table)

my_table$c <- my_table$a + my_table$b
print(my_table)
```
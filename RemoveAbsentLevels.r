d <- data.frame(
    x = c("A","B","C"), 
    y = c(1,2,3)
)
d

e <- d[d$y != 2,]
e$x # Levels: A B C

e$x <- droplevels(e$x)
e$x # Levels: A C

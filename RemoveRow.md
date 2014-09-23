# Remove a row

```
d <- data.frame(
    x = c(1,1,1,2,2,2,3,3,3), 
    y = c(1,2,3,1,2,3,1,2,3), 
    z = c(1,2,3,4,5,6,7,8,9)
)
d

# Assume y is a type treatment
# Only select treatment 2
e <- subset(d,y == 2)
e

f <- d[d$y == 2,]
f

e == f
```

Before:

```
  x y z
1 1 1 1
2 1 2 2
3 1 3 3
4 2 1 4
5 2 2 5
6 2 3 6
7 3 1 7
8 3 2 8
9 3 3 9
```

After:

```
  x y z
2 1 2 2
5 2 2 5
8 3 2 8
```

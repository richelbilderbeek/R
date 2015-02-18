# Transpose

```
# 1 2 3    1 4 7
# 4 5 6 -> 2 5 8
# 7 8 9    3 6 9

d <- data.frame(
    x = c(1,4,7),
    y = c(2,5,8),
    z = c(3,6,9)
)
d

e <- t(d)
e
```

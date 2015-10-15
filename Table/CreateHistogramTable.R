# A
# B
# B    A 1
# C -> B 2
# C    C 3
# C

d <- data.frame(
    x = c("A","B","B","C","C","C")
)
d

cbind(f=table(d))

# More elaborate:
# cbind(Freq=table(d), Cumul=cumsum(table(d)), relative=prop.table(table(d)))

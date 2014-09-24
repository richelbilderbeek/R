# Tally

```
# +--- Species 
# |
# | +- Distance
# | |      |
# A 1      | frequecies
# B 2      | A B C
# B 3      1 1 0 1
# C 1  ->  2 0 2 1
# C 2      3 0 1 3
# C 3
# B 2 <- let frequency of B at distance 2cm be 2
# C 3 <-+
# C 3 <-+- let frequency of C at distance 3cm be 3

d <- data.frame(
    name = c("A","B","B","C","C","C","B","C","C"),
    distance = c("1cm","2cm","3cm","1cm","2cm","3cm","2cm","3cm","3cm")
)
d

species_tally <- dcast(d,distance ~ name,fill = 0, fun.aggregate=length) # fun.aggregate may also be mean
species_tally

```

# +------ Key
# | +---- Replicate
# | | +-- Value
# | | |
# 2 1 1 
# 2 2 2
# 2 3 3
# -----
# 3 1 4      2 2
# 3 2 5  ->  3 5
# 3 3 6      4 8
# -----
# 4 1 7
# 4 2 8
# 4 3 9

#z = c(1,2,3,4,5,6,7,8,9)
d <- data.frame(
    x = c(2,2,2,3,3,3,4,4,4), 
    #y = c(1,2,3,1,2,3,1,2,3), 
    #z = c(1,2,3,4,5,6,7,8,9)
	  z = seq(1,9,1)
)
d

# Assume y is the replicate number
# Get rid of it, average the others
e <- aggregate(z,list(as.factor(d$x)),mean)
e






# +------ Key, e.g. distance
# | +---- Secondary key, e.g. depth
# | | +---- Replicate
# | | | +-- Value
# | | | |
# 2 1 1 2 
# 2 1 2 4
# ------- 
# 2 2 1 3
# 2 2 2 5    2 1 3
# ------- -> 2 2 4
# 3 1 1 4    3 1 5
# 3 1 2 6    3 2 6
# -------
# 3 2 1 5
# 3 2 2 7
# -------

f <- data.frame(
    k = c(2,2,2,2,3,3,3,3),
    l = c(1,1,2,2,1,1,2,2),
#    l = c("A","A","B","B","A","A","B","B"), # aggregate cannot handle non-numerics
#    r = c(1,2,1,2,1,2,1,2),  #Will be averaged to 1.5
    z = c(2,4,3,5,4,6,5,7)
)
f 

# Assume y is the replicate number
# Get rid of it, average the others
#g <- aggregate(f,list(as.factor(f$z)),mean)
g <- aggregate(f,list(f$l,f$k),mean)
g

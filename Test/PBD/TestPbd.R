rm(list=ls())

library(ape) # As suggested in PBD issue #3

# Load all PBD functions
pbd_path <- "~/GitHubs/PBD/PBD/R"
for (file in list.files(path = pbd_path)) {
  source(paste(pbd_path,"/",file,sep=""));
}


# Call pbd_sim as in example
pbd_sim(c(0.2,1,0.2,0.1,0.1),15)

# Check if seed works correctly
library(testit)
set.seed(42)
result1 <- pbd_sim(c(0.2,1,0.2,0.1,0.1),15)
set.seed(42)
result2 <- pbd_sim(c(0.2,1,0.2,0.1,0.1),15)
assert(all.equal(result1,result2))
assert(all.equal(result1$stree,result2$stree))

# Extracts stree
age <- 5
for (seed in c(0:1000))
{
  set.seed(seed)
  print(seed)
  b_1  <- 1.0 # b_1 , the speciation-initiation rate of good species 
  la_1 <- 0.5 # la_1, the speciation-completion rate 
  b_2  <- 0.2 # b_2 , the speciation-initiation rate of incipient species 
  mu_1 <- 0.5 # mu_1, the extinction rate of good species 
  mu_2 <- 0.1 # mu_2, the extinction rate of incipient species 
  
  result <- pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age)
  plot(result$tree)
  
  absL = result$L0
  absL[,2] = abs(result$L0[,2])
  sL1 = sampletree(absL,age)
  stree1 = as.phylo(read.tree(text = detphy(sL1,age)))
  sL2 = sampletree(absL,age)
  stree2 = as.phylo(read.tree(text = detphy(sL2,age)))
  plot(stree1)
  #plot(stree2)
  if (all.equal(sL1,sL2) == FALSE) {
    print(seed)
    stop()
  }
  assert(all.equal(sL1,sL2))
}

n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))
plot(stree1)
plot(stree2)
par(mfrow=c(1,1))


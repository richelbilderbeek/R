source("~/GitHubs/R/Plot/plot_ltt.R")

library("TreeSim")

plot_ltt_test <- function() {
  phylogeny <- rcoal(10)
  plot_ltt(phylogeny, main = "plot_ltt_test")
}

plot_ltt_test()

numbsim<-10
age<-10
lambda<-0.3
mu<-0.1
K<-40
 
??LTT.average
??TreeSim
trees <- list(rcoal(10),rcoal(10))
trees
LTT.plot(trees)
ltttrees <- LTT.average.root(trees)

plot(ltttrees,type='l',col='black',log="y",xlab="time",ylab="number of species")
LTT.plot(c(trees,list(c(10,10))))

LTT.plot(trees = trees)
?LTT.plot


# Simulation of a tree of age 10 under the density-dependent model
numbsim<-3
age<-10
lambda<-0.3
mu<-0
K<-40
tree<- sim.bd.age(age,numbsim,lambda,mu,mrca=FALSE,complete=FALSE,K=K)
class(tree)
# Plot of tree
LTT.plot(c(list(tree),list(c(age,age,age))))
#
# Simulation of a tree with 10 tips under the constant rate birth-death model
numbsim<-3
n<-10
lambda<-0.3
mu<-0
tree<- sim.bd.taxa(10,numbsim,lambda,mu,complete=FALSE,stochsampling=TRUE)
# Plot of tree
ages<-c()
for (i in 1:length(tree)){
    ages<-c(ages,tree[[i]]$root.edge+max(getx(tree[[i]])))
}
LTT.plot(c(list(tree),list(ages)),avg=TRUE)
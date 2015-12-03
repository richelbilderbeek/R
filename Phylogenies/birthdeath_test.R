library(ape)

birthdeath_test <- function() {
  
  p = rcoal(6)
  
  p[1]
  
#         [,1] [,2]
#    [1,]    7    1
#    [2,]    7    8
#    [3,]    8    2
#    [4,]    8    9
#    [5,]    9   11
#    [6,]   11    3
#    [7,]   11    4
#    [8,]    9   10
#    [9,]   10    5
#   [10,]   10    6
  
  p[2]
  
#    [1] 1.17105933 0.33839694 0.83266239 0.34503070 0.42684794 0.06078375
#    [7] 0.06078375 0.29238994 0.19524175 0.19524175
   
  plot(p)
  
  birthdeath(p)
  
#   Estimation of Speciation and Extinction Rates
#               with Birth-Death Models
#   
#        Phylogenetic tree: p 
#           Number of tips: 6 
#                 Deviance: -1.97325 
#           Log-likelihood: 0.9866252 
#      Parameter estimates:
#         d / b = 0.8636292   StdErr = 0.8534694 
#         b - d = 0.206467   StdErr = 1.207967 
#      (b: speciation rate, d: extinction rate)
#      Profile likelihood 95% confidence intervals:
#         d / b: [0.4038332, 0.9667787]
#         b - d: [0.05009193, 0.7198563]
}

birthdeath_test()
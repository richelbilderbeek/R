rm(list = ls())
library(testit)
setwd("/home/richel/GitHubs/R")
source('Genetics.R')

#
# Goal: calculate the covariance between parent and offspring
#
# There are two alleles: p (or A) and q (or a)
#
t <- matrix(0,0,2)
t
for (pA in seq(0.0,1.0,0.1))
{
	# pA <- 0.5
	genotype_frequencies_fathers <- GetGenotypeFrequenciesFromAlleleFrequencies(CreateAlleleFrequencies(pA))
	genotype_frequencies_fathers
	gamete_allele_frequencies <- GetAlleleFrequenciesFromGenotypeFrequencies(genotype_frequencies_fathers)

	gff <- genotype_frequencies_fathers
	gaf <- gamete_allele_frequencies

	m <- data.frame(matrix(0,3,3))
	colnames(m) <- c("AA","Aa","aa")
	rownames(m) <- c("AA","Aa","aa")
	
	# m[son genotype,father genotype]
	m["AA","AA"]=(1.0*gaf$A)
	m["Aa","AA"]=(1.0*gaf$a)
	m["aa","AA"]=(0.0      )
	
	m["AA","Aa"]=(0.5*gaf$A)
	m["Aa","Aa"]=(0.5)
	m["aa","Aa"]=(0.5*gaf$a)
	
	m["AA","aa"]=(0.0      )
	m["Aa","aa"]=(1.0*gaf$a)
	m["aa","aa"]=(1.0*gaf$A)

	m
#   minimum_nonzero <- min(m[m>0])
#   n <- m / minimum_nonzero
  n <- m * 400
  n[,"AA"] <- n[,"AA"]*gff$AA
  n[,"Aa"] <- n[,"Aa"]*gff$Aa
  n[,"aa"] <- n[,"aa"]*gff$aa
	n
	#Son,Father
	if (pA == 0.5)
	{
		assert("",n["AA","AA"]==50)
		assert("",n["Aa","AA"]==50)
		assert("",n["aa","AA"]== 0)
		
		assert("",n["AA","Aa"]==50)
		assert("",n["Aa","Aa"]==100)
		assert("",n["aa","Aa"]==50)
		
		assert("",n["AA","aa"]==0)
		assert("",n["Aa","aa"]==50)
		assert("",n["aa","aa"]==50)
	}	
	# Convert the table to coordinats
  c <- matrix(0,0,2)
	for (son_genotype in 1:3)
	{
		# Score according to Sinervo & Lively (1996) Nature
		# AA: 0
		# Aa: 1
		# aa: 2
		score_y <- 0
		
		if (son_genotype == 1) { score_y <-  0 } # AA
		if (son_genotype == 2) { score_y <-  0.5 } # Aa
		if (son_genotype == 3) { score_y <-  0.9 } # aa
# 		if (son_genotype == 1) { score_y <-  0 } # AA
# 		if (son_genotype == 2) { score_y <-  1 } # Aa
# 		if (son_genotype == 3) { score_y <-  2 } # aa
# 		if (son_genotype == 1) { score_y <-  1 } # AA
# 		if (son_genotype == 2) { score_y <- -1 } # Aa
# 		if (son_genotype == 3) { score_y <-  0 } # aa
	  for (father_genotype in 1:3)	
	  {
	  	n_sons <- n[son_genotype,father_genotype]
	  	if (n_sons != 0)
	  	{
		  	for (i in 1:n_sons)
		  	{
		  		score_x <- 0
					if (father_genotype == 1) { score_x <-  0 } # AA
					if (father_genotype == 2) { score_x <-  0.5 } # Aa
					if (father_genotype == 3) { score_x <-  0.9 } # aa
# 					if (father_genotype == 1) { score_x <-  0 } # AA
# 					if (father_genotype == 2) { score_x <-  1 } # Aa
# 					if (father_genotype == 3) { score_x <-  2 } # aa
# 					if (father_genotype == 1) { score_x <-  1 } # AA
# 					if (father_genotype == 2) { score_x <- -1 } # Aa
# 					if (father_genotype == 3) { score_x <-  0 } # aa
			  	c <- rbind(c,t(c(score_x,score_y)))
		  	}
	  	}
	  }
  }
  c
  my_slope <- coef(lm(c[,2] ~ c[,1]))[2]
  plot(
  	jitter(c),
	  main=paste(
	  	 "pA: ",pA,
	  	", slope: ",my_slope,
	  	sep=""
	  ),
  	xlab="Phenotype score father (0:AA, 1:Aa, 2:aa)",
  	ylab="Phenotype score sons (0:AA, 1:Aa, 2:aa)"
  )
	t <- rbind(t,t(c(pA,my_slope * 2)))

} #Next pA

t
plot(
	t,
	main="Heritabilities for different allele frequencies",
	xlab="pA",
	ylab="Heritability",
	t="b"
)
	


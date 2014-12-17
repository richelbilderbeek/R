library(testit)


CreateAlleleFrequencies <- function(fA, fa = 1 - fA)
{
	assert("Allele frequency of A must be in range [0,1]",fA >= 0.0 && fA <= 1.0)
	assert("Allele frequency of a must be in range [0,1]",fa >= 0.0 && fa <= 1.0)
	assert("Allele frequencies must sum up to one",abs(fA + fa - 1) < 0.0001)
	n_rows <- 1
	n_cols <- 2
	fs <- data.frame(matrix(c(fA,fa),n_rows,n_cols))
	colnames(fs) <- c("A","a")
	rownames(fs) <- c("f")
	return (fs)
}

CreateGenotypeFrequencies <- function(fAA, fAa, faa = 1 - fAA - fAa)
{
	assert("Genotype frequency of AA must be in range [0,1]",fAA >= 0.0 && fAA <= 1.0)
	assert("Genotype frequency of Aa must be in range [0,1]",fAa >= 0.0 && fAa <= 1.0)
	assert("Genotype frequency of aa must be in range [0,1]",faa >= 0.0 && faa <= 1.0)
	assert("Genotype frequencies must sum up to one",abs(fAA + fAa + faa - 1) < 0.0001)
	n_rows <- 1
	n_cols <- 3
	fs <- data.frame(matrix(c(fAA,fAa,faa),n_rows,n_cols))
	colnames(fs) <- c("AA","Aa","aa")
	rownames(fs) <- c("f")
	return (fs)
}

GetAlleleFrequenciesFromGenotypeFrequencies <- function(genotype_frequencies)
{
	assert("Colnames must be AA, Aa and aa (for now)",colnames(genotype_frequencies) == c("AA","Aa","aa"))
  pA <- genotype_frequencies$AA + (0.5 * genotype_frequencies$Aa)
  pa <- genotype_frequencies$aa + (0.5 * genotype_frequencies$Aa)
	return (CreateAlleleFrequencies(pA,pa))
}

GetGenotypeFrequenciesFromAlleleFrequencies <- function(allele_frequencies)
{
	assert("Colnames must be A a (for now)",colnames(allele_frequencies) == c("A","a"))
	pA <- allele_frequencies$A
	pa <- allele_frequencies$a
  pAA <- pA * pA
  pAa <- 2 * pA * pa
  paa <- pa * pa
	return (CreateGenotypeFrequencies(pAA,pAa,paa))
}


GeneticsTest <- function()
{
	# CreateAlleleFrequencies for two frequencies
  {
  	pA <- 0.7
  	pa <- 0.3
    assert("",CreateAlleleFrequencies(pA,pa)$A == pA)
    assert("",CreateAlleleFrequencies(pA,pa)$a == pa)
  }
	# CreateAlleleFrequencies for one frequency
  {
  	pA <- 0.2
    assert("",CreateAlleleFrequencies(pA)$A == pA)
  }
	# CreateGenotypeFrequencies for three frequencies
  {
  	pAA <- 0.2
  	pAa <- 0.3
  	paa <- 1.0 - pAA - pAa
    assert("",CreateGenotypeFrequencies(pAA,pAa,paa)$AA == pAA)
    assert("",CreateGenotypeFrequencies(pAA,pAa,paa)$Aa == pAa)
    assert("",CreateGenotypeFrequencies(pAA,pAa,paa)$aa == paa)
  }
	# CreateGenotypeFrequencies for two frequencies
  {
  	pAA <- 0.2
  	pAa <- 0.3
  	paa <- 1.0 - pAA - pAa
    assert("",CreateGenotypeFrequencies(pAA,pAa,paa)$AA == pAA)
    assert("",CreateGenotypeFrequencies(pAA,pAa,paa)$Aa == pAa)
    assert("",CreateGenotypeFrequencies(pAA,pAa,paa)$aa == paa)
  }
	# GetAlleleFrequenciesFromGenotypeFrequencies for easiest case
  {
  	pAA <- 0.25
  	pAa <- 0.50
  	paa <- 0.25  	
  	genotype_frequencies <- CreateGenotypeFrequencies(pAA,pAa,paa)
  	allele_frequencies <- GetAlleleFrequenciesFromGenotypeFrequencies(genotype_frequencies)
  	assert("",allele_frequencies$A == 0.5)
  	assert("",allele_frequencies$a == 0.5)
  }
	# GetAlleleFrequenciesFromGenotypeFrequencies for easiest case
  {
  	pA <- 0.1
  	pa <- 1.0 - pA
  	pAA <- pA * pA
  	pAa <- 2 * pA * pa
  	paa <- pa * pa
  	genotype_frequencies <- CreateGenotypeFrequencies(pAA,pAa,paa)
  	allele_frequencies <- GetAlleleFrequenciesFromGenotypeFrequencies(genotype_frequencies)
  	assert("",allele_frequencies$A == pA)
  	assert("",allele_frequencies$a == pa)
  }
	# GetGenotypeFrequenciesFromAlleleFrequencies
  {
  	pA <- 0.1
  	pa <- 1.0 - pA
  	allele_frequencies <- CreateAlleleFrequencies(pA,pa)
  	genotype_frequencies <- GetGenotypeFrequenciesFromAlleleFrequencies(allele_frequencies)
  	pAA <- pA * pA
  	pAa <- 2 * pA * pa
  	paa <- pa * pa
  	assert("",genotype_frequencies$AA == pAA)
  	assert("",genotype_frequencies$Aa == pAa)
  	assert("",genotype_frequencies$aa == paa)
  }
}

GeneticsTest()

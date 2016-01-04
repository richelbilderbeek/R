library(PBD)

rng_seed <- 42
species_initiation_rate_good_species <- 0.5
species_initiation_rate_incipient_species <- 0.5
speciation_completion_rate <- 1.0
extinction_rate_good_species <- 0.1
extinction_rate_incipient_species <- 0.1
#age <- 6

for (age in seq(6,7,0.01))
{
  set.seed(rng_seed)
  pbd_output <- pbd_sim(c(species_initiation_rate_good_species,speciation_completion_rate,species_initiation_rate_incipient_species,extinction_rate_good_species,extinction_rate_incipient_species),age=age,soc=2,plot=FALSE)
  plot(pbd_output$tree)
}

i <- 0
for (age in seq(6,7,0.01))
{
  png(paste(i,".png",sep=""))
  set.seed(rng_seed)
  pbd_output <- pbd_sim(c(species_initiation_rate_good_species,speciation_completion_rate,species_initiation_rate_incipient_species,extinction_rate_good_species,extinction_rate_incipient_species),age=age,soc=2,plot=FALSE)
  plot(pbd_output$tree)
  dev.off()
  i <- i + 1
}


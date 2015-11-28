library(PBD)

create_random_protracted_birth_death_tree <- function(
  speciation_initiation_rate_good_species,
  speciation_completion_rates,
  speciation_initiation_rate_incipient_species,
  extinction_rate_good_species,
  extinction_rate_incipient_species,
  crown_age,
  do_plot = FALSE
)
{
  out <- pbd_sim(
    c(
      speciation_initiation_rate_good_species,
      speciation_completion_rates,
      speciation_initiation_rate_incipient_species,
      extinction_rate_good_species,
      extinction_rate_incipient_species
    ),
    crown_age,
    soc = 2, #Stem or crown age? 2 == crown age
    plot = do_plot
  )
  if (do_plot) {
     par(mfrow=c(1,1)) # Bug fix of https://github.com/richelbilderbeek/Wip/issues/20
  }
  return (out)
}
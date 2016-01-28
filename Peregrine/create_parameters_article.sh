#!/bin/bash
b_index=0
for b in 0.1 0.2 0.4 0.8
do
  lambda_index=0
  for lambda in 0.0 0.1 0.2 0.4 0.8 1000000
  do
    mu_index=0
    for mu in 0.0 0.1 0.2 0.4 0.8
    do
      r_index=0
      for r in 0.1 0.01 0.001
      do
        l_index=0
        for l in 1000 10000 10000
        do
          rng_seed=1
          crown_age=5
          n_species_trees=2
          n_alignments=2
          mcmc_length=1000000
          n_beast_runs=2
          filename='article_'$b_index'_'$lambda_index'_'$mu_index'_'$r_index'_'$l_index'.RDa'
          Rscript create_parameter_file.R $rng_seed $b $b $lambda $mu $mu $crown_age $n_species_trees $r $n_alignments $l $mcmc_length $n_beast_runs $filename
          l_index=$((l_index+1))
        done # l
        r_index=$((r_index+1))
      done # r
      mu_index=$((mu_index+1))
    done # mu
    lambda_index=$((lambda_index+1))
  done # lambda
  b_index=$((b_index+1))
done # b
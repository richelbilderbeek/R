#!/bin/bash
Rscript create_parameter_file.R 1 0.5 0.5 1000000 0.1 0.1 5 1 0.01 1 1000 10000 1 toy_example_1.RDa
Rscript create_parameter_file.R 1 0.5 0.5     0.1 0.1 0.1 5 1 0.01 1 1000 10000 1 toy_example_2.RDa
Rscript create_parameter_file.R 1 0.5 0.5 1000000 0.1 0.1 5 2 0.01 2 1000 10000 2 toy_example_3.RDa
Rscript create_parameter_file.R 1 0.5 0.5     0.1 0.1 0.1 5 2 0.01 2 1000 10000 2 toy_example_4.RDa

#!/bin/bash
./create_example_parameter_files.sh
./do_simulation_examples.sh
./do_analyze_examples.sh
mv *.png ~/GitHubs/Wip/RichelBilderbeek/ArticlesInProgress/ShouldProtractedSpeciationBeIncorporatedInPhylogeneticTreeConstructionMethods

#!/bin/bash
./create_example_parameter_files.sh
./do_simulation_examples.sh
./do_analyze_examples.sh
dot -Tsvg Workflow_experiment.dot -o Workflow_experiment.svg
dot -Tsvg Workflow_code.dot -o Workflow_code.svg
./check_example_parameter_files.sh > check_example_parameter_files.txt

#!/bin/bash
Rscript analyse.R toy_example_1.RDa
Rscript analyse.R toy_example_2.RDa
Rscript analyse.R toy_example_1.RDa toy_example_2.RDa
mv multi_average_nltts.png toy_example_12_average_nltts.png
mv multi_nltt_stats_histogram.png toy_example_12_nltt_stats_histogram.png
Rscript analyse.R toy_example_3.RDa
Rscript analyse.R toy_example_4.RDa
Rscript analyse.R toy_example_3.RDa toy_example_4.RDa
mv multi_average_nltts.png toy_example_34_average_nltts.png
mv multi_nltt_stats_histogram.png toy_example_34_nltt_stats_histogram.png
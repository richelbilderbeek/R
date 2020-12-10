#!/bin/bash
Rscript analyse.R example_1.RDa
Rscript analyse.R example_2.RDa
Rscript analyse.R example_1.RDa example_2.RDa
mv multi_average_nltts.png example_12_average_nltts.png
mv multi_nltt_stats_histogram.png example_12_nltt_stats_histogram.png
Rscript analyse.R example_3.RDa
Rscript analyse.R example_4.RDa
Rscript analyse.R example_3.RDa example_4.RDa
mv multi_average_nltts.png example_34_average_nltts.png
mv multi_nltt_stats_histogram.png example_34_nltt_stats_histogram.png
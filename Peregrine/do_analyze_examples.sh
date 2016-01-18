#!/bin/bash
Rscript do_analyze.R example_1.RDa
Rscript do_analyze.R example_2.RDa
Rscript do_analyze.R example_1.RDa example_2.RDa
mv multi_average_nltts.png example_12_average_nltts.png
mv multi_nltt_stats_histogram.png example_12_nltt_stats_histogram.png
Rscript do_analyze.R example_3.RDa
Rscript do_analyze.R example_4.RDa
Rscript do_analyze.R example_3.RDa example_4.RDa
mv multi_average_nltts.png example_34_average_nltts.png
mv multi_nltt_stats_histogram.png example_34_nltt_stats_histogram.png
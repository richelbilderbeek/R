#!/bin/bash
Rscript do_analyze.R toy_example_1.RDa
Rscript do_analyze.R toy_example_2.RDa
Rscript do_analyze.R toy_example_1.RDa toy_example_2.RDa
mv multi_average_nltts.png toy_example_12_average_nltts.png
mv multi_nltt_stats_histogram.png toy_example_12_nltt_stats_histogram.png
Rscript do_analyze.R toy_example_3.RDa
Rscript do_analyze.R toy_example_4.RDa
Rscript do_analyze.R toy_example_3.RDa toy_example_4.RDa
mv multi_average_nltts.png toy_example_34_average_nltts.png
mv multi_nltt_stats_histogram.png toy_example_34_nltt_stats_histogram.png
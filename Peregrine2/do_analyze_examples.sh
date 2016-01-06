#!/bin/bash
Rscript do_analyze.R example_1.RDa
Rscript do_analyze.R example_2.RDa
Rscript do_analyze.R example_1.RDa example_2.RDa
mv average_nltts.png example_average_nltts.png
mv nltt_stats_histogram.png example_nltt_stats_histogram.png
#!/bin/bash

for FILE in `ls article_*.RDa`
do
  echo $FILE
  #Rscript do_analyze.R $FILE
done

#Rscript do_analyze.R example_1.RDa example_2.RDa
#mv multi_average_nltts.png example_12_average_nltts.png
#mv multi_nltt_stats_histogram.png example_12_nltt_stats_histogram.png

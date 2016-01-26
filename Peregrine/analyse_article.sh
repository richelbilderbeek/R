#!/bin/bash
for filename in `ls article_*.RDa`
do
  Rscript do_analyse.R $filename
done


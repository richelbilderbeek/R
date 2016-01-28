#!/bin/bash
for filename in `ls article_*.RDa`
do
  Rscript analyse.R $filename
done


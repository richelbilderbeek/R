#!/bin/bash

./DownloadApe.sh

if [ HOSTNAME ]
then
  echo "HOSTNAME: "$HOSTNAME
else
  echo "HOSTNAME not found"
fi

if [ "fwn-biol-132-102" == "$HOSTNAME" ]
then
  echo "My working computer"
  R CMD INSTALL ./MyFavoritePackages/ape
else
  echo "This is not my working computer"
fi

if [ "pg-login" == "$HOSTNAME" ]
then
  echo "Peregine login computer"
  module load R/3.1.2-goolfc-2.7.11-default
  R CMD INSTALL ./MyFavoritePackages/ape
else
  echo "This is not my working computer"
fi



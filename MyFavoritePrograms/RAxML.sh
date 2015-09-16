#!/bin/bash

if [ ! -d standard-RAxML ]
then
git clone https://github.com/stamatak/standard-RAxML.git
fi

cd standard-RAxML
make -f Makefile.gcc
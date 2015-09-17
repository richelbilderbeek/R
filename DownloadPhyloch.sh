
if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

#
# phyloch
#


PHYLOCH_FILE=phyloch_1.5-5.tar.gz

if [ ! -e MyFavoritePackages/$PLYR_FILE ]
then
  echo "Downloading phyloch tar"
  wget http://www.christophheibl.de/$PHYLOCH_FILE
  mv $PHYLOCH_FILE MyFavoritePackages/$PHYLOCH_FILE
else
  echo "phyloch tar already on disc"
fi

if [ ! -d MyFavoritePackages/phyloch ]
then
  echo "Unpacking phyloch tar"
  cd MyFavoritePackages
  tar zxvf $PHYLOCH_FILE
  cd ..
else
  echo "phyloch tar already unpacked"
fi
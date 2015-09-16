
if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

#
# PBD
#

PBD_FILE=PBD_1.0.tar.gz

if [ ! -e MyFavoritePackages/$PBD_FILE ]
then
  wget https://cran.r-project.org/src/contrib/$PBD_FILE
  mv $PBD_FILE MyFavoritePackages/$PBD_FILE
fi

if [ ! -d MyFavoritePackages/PBD ]
then
  cd MyFavoritePackages
  tar zxvf $PBD_FILE
  cd ..
fi

if [ ! -e MyFavoritePackages/PBD.pdf ]
then
  wget https://cran.r-project.org/web/packages/PBD/PBD.pdf
  mv PBD.pdf MyFavoritePackages/PBD.pdf
fi

#
# plyr
#

PLYR_FILE=plyr_1.8.3.tar.gz



if [ ! -e MyFavoritePackages/$PLYR_FILE ]
then
  echo "Downloading plyr tar"
  wget https://cran.r-project.org/src/contrib/$PLYR_FILE
  mv $PLYR_FILE MyFavoritePackages/$PLYR_FILE
else
  echo "plyr tar already on disc"
fi

if [ ! -d MyFavoritePackages/plyr ]
then
  echo "Unpacking plyr tar"
  cd MyFavoritePackages
  tar zxvf $PLYR_FILE
  cd ..
else
  echo "plyr tar already unpacked"
fi

## Hack dependencies to 3.0.2
echo "Hack plyr dependencies to 3.0.2"

cd MyFavoritePackages
rm $PLYR_FILE
sed -i plyr/DESCRIPTION -e 's/Depends: R (>= 3.1.0)/Depends: R (>= 3.0.2)/'
tar cvzf $PLYR_FILE plyr/*



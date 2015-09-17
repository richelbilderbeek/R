
if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

FILE=phyloch_1.5-5.tar.gz
FOLDER=phyloch

if [ ! -e MyFavoritePackages/$FILE ]
then
  echo "Downloading tar"
  wget http://www.christophheibl.de/$FILE
  mv $FILE MyFavoritePackages/$FILE
else
  echo "Tar already on disc"
fi

if [ ! -d MyFavoritePackages/$FOLDER ]
then
  echo "Unpacking tar"
  cd MyFavoritePackages
  tar zxvf $FILE
  cd ..
else
  echo "Tar already unpacked"
fi

# Apply fix to newer version of RAxML that need anm additional parameter
wget https://raw.githubusercontent.com/richelbilderbeek/R/master/MyFavoritePackages/phyloch/R/raxml.R

mv -f raxml.R MyFavoritePackages/phyloch/R/raxml.R
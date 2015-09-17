
if [ ! -d MyFavoritePackages ]
then
  mkdir MyFavoritePackages
fi

./DownloadPdb.sh
./DownloadPhyloch.sh
./DownloadPlyr.sh

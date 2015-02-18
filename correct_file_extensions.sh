# Replace the .r extension by the .R extension, as recommended in Google's R Style Guide
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml#filenames

for old_filename in `ls *.r | egrep "\\.r$"`;
do
  echo $old_filename
  #mv $new_trees_file $trees_file
  new_filename=`echo $old_filename | sed -e "s/\\.r/\\.R/g"`
  echo $new_filename
  mv $old_filename $new_filename
done

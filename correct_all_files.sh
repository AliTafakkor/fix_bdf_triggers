#! /bin/sh
for file in ./*.bdf
do
  echo correcting triggers of $file
  echo ---------------------------------------------------------------
  matlab -nodisplay -nosplash -nodesktop -r "correct_triggers('$file'); exit;" | tail -n +11
done 

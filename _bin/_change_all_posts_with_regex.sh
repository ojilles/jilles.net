#! /bin/bash

FILES=`ls -1 *.md`

echo Applying regex to all posts

for FILE in $FILES
do
    echo $FILE
    cat "$FILE" | sed -e "s/\(permalink.*\)\//\1/g" > _324232_tmp_file.md
    mv _324232_tmp_file.md $FILE
done

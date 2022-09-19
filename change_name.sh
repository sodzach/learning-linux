#!/bin/bash
echo "Please type the path you need to change the file name: "
read dir
cd $dir

for file in *
    do
    NAME=`echo "$file" | cut -d'.' -f1`
    EXTENSION=`echo "$file" | cut -d'.' -f2`
    NAME="$NAME"-bkup
    echo "Rename '$file' to '$dir/$NAME.$EXTENSION'"
    mv $file $NAME.$EXTENSION

done

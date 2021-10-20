# !/usr/bin/bash

if [[ -f list_of_different_files.txt ]] 
then
    rm list_of_different_files.txt
fi

git clone $1
directory=$( echo $1 | sed 's/.*\/\(\S*\)\.git$/\1/' )
cd $directory
git switch $3
git switch $2
touch ../list_of_different_files.txt
git diff $2..$3 --name-only --output=../list_of_different_files.txt
cd ..
rm -rf $directory
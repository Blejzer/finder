#!/bin/bash
# Media files locator

# initation sequence start
Date=$(date +"%Y-%m-%d_%H%M%S")
declare -a arry=("/opt/samba")

result="./result_$Date.txt"
files="./filesToProcess.txt"
time=$((30*12*7))

echo 'Files locator initiates...' > $result
echo 'Date: '$Date >> $result

# initiation sequence end

# Files search start

echo 'Start search for files...' >> $result
for i in "${arry[@]}"
do
   echo "Search for files in $i ..." >> $result
#   find $i -type f -iname "*" >> $files
   find $i -type f -mtime +$time >> $files
   echo   >> $result
   echo 'Files found...' >> $result
   echo '___________________________________________________________' >> $result
done

echo 'Finished search for files. Results are saved in '$files >> $result
echo '___________________________________________________________' >> $result
echo >> $result

# Files search end

# Files size evaluation start

echo 'Starting size evaluation...' >> $result
echo 'Size evaluation:' >> $result

size=0
num=0
list=$files

while IFS='\n' read -r list || [[ -n "$list" ]];
do
    ((num++))

    sizetemp=$(stat -c "%s" "$list")
    size=$(($size+$sizetemp))

done <  "$list"

size=$(($size/1024/1024))
echo 'Total size of found files in '$list': '$size' MB' >> $result
echo '-------------------------------------------------------' >> $result
echo 'List of '$num' found files is saved in '$list' file.' >> $result
echo  >> $result

# Files size evaluation end

echo 'Media files locator results are saved in '$result' file.'

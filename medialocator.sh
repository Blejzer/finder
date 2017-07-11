#!/bin/bash
# Media files locator

# initation sequence start
Date=$(date +"%Y-%m-%d_%H%M%S")
echo 'Hello, please enter absolute path to folders you need scanned:'
read arry
echo 'I will now scan '$arry' for media files'
# declare -a arry=("/home/" "/opt/samba/public/")
if [ ! -d results ]; then
  mkdir -p results;
fi
result="results/result_$Date.txt"
mp3files="results/mp3files_$Date.txt"
videofiles="results/videofiles_$Date.txt"

echo 'Media files locator initiates...' > $result
echo 'Date: '$Date >> $result

# initiation sequence end

# MP3 files search start

echo 'Start search for mp3 files...' >> $result
for i in "${arry[@]}"
do
   echo "Search for mp3 files in $i ..." >> $result
   find $i -type f -iname "*.mp3" >> $mp3files
   echo   >> $result
   echo 'Files found...' >> $result
   echo '___________________________________________________________' >> $result
done

echo 'Finished search for mp3 files. Results are saved in '$mp3files >> $result
echo '___________________________________________________________' >> $result
echo >> $result

# MP3 files search end

# MP3 files size evaluation start

echo 'Starting size evaluation...' >> $result
echo 'Size evaluation:' >> $result

size=0
num=0
list=$mp3files

while IFS='\n' read -r list || [[ -n "$list" ]];
do
    ((num++))

    sizetemp=$(stat -c "%s" "$list")
    size=$(($size+$sizetemp))

done <  "$list"

size=$(($size/1024/1024))
echo 'Total size of found mp3 files in '$list': '$size' MB' >> $result
echo '-------------------------------------------------------' >> $result
echo 'List of '$num' found files is saved in '$list' file.' >> $result
echo  >> $result

# MP3 files size evaluation end

# Video files search start

echo 'Start search for video files...' >> $result
echo  >> $result
for i in "${arry[@]}"
do
   echo "Search for video files in $i ..." >> $result
   find /home/ -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p' > $videofiles
   echo   >> $result
   echo 'Files found...' >> $result
   echo '___________________________________________________________' >> $result
done
echo 'Finished search for video files. Results are saved in '$videofiles >> $result
echo '___________________________________________________________' >> $result
echo >> $result
# Video files search end

# Video files size evaluation start

vlist=$videofiles

vsize=0
vnum=0
echo 'Starting size evaluation...' >> $result

while IFS='\n' read -r vlist || [[ -n "$vlist" ]];
 do
  ((vnum++))

  vsizetemp=$(stat -c "%s" "$vlist")
  vsize=$(($vsize+$vsizetemp))

done <  "$vlist"
vsize=$(($vsize/1024/1024))
echo >> $result
echo '___________________________________________________________' >> $result
echo >> $result
echo 'Files found...' >> $result
echo 'Finished evaluation.' >> $result
echo 'Total size of found video files: '$vsize' MB' >> $result
echo '-------------------------------------------------------' >> $result
echo 'List of '$vnum' found files is saved in '$videofiles >> $result
echo  >> $result

# Video files size evaluation end

echo 'Media files locator results are saved in '$result' file.'

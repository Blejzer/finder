#!/bin/bash
# Media files locator

# INIT - initation sequence start
Date=$(date +"%Y-%m-%d_%H%M%S")

clear

## INIT - Getting all of the required information to start scanning
echo 'Hello, please enter absolute path to folders you need scanned (/test/ ~/Library/ /opt/samba/):'
read -a arry
counter=0
for i in "${arry[@]}"
do
  echo 'Checking if '$i' exists'
  if [ -d "$i" ]; then
    ((counter++))
    echo 'Checked. '$i' will be scanned for media files'
    echo
    else
    echo 'Folder '$i' you entered is not accessible, please re-run the script and enter absolute path to the folders you want to scan'
    echo '======================='
    echo
  fi

  if [ $counter -eq 0 ]; then
    echo 'No scannable folders found. Please review script documentation, and try again'
    echo '======================='
    echo
    exit 1
  fi
done
sleep 2

if [ ! -d results ]; then
  mkdir -p results;
fi
## COMPLETED - Getting all of the required information to start scanning
result="results/result_$Date.txt"
mp3files="results/audioFiles_$Date.txt"
videofiles="results/videoFiles_$Date.txt"

echo 'Media files locator initiates...' > $result
echo 'Date: '$Date >> $result

# COMPLETED - initiation sequence end

# INIT - Audio files search

echo 'Start search for audio files...' >> $result
for i in "${arry[@]}"
do
   echo "Search for audio files in $i ..." >> $result
   #find $i -type f -iname "*.mp3" >> $mp3files
   find $i -type f | grep "/*.ogg\|/*.mp3\|/*.wav\|/*.wma\|/*.m3u\|/*.pls" >> $mp3files
   echo   >> $result
   echo 'Files found...' >> $result
   echo '___________________________________________________________' >> $result
done

echo 'Finished search for audio files. Results are saved in '$mp3files >> $result
echo '___________________________________________________________' >> $result
echo >> $result

# COMPLETED - Audio files search

# INIT - Audio files size evaluation

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
echo 'Total size of found audio files in '$mp3files': '$size' MB' >> $result
echo '-------------------------------------------------------' >> $result
echo 'List of '$num' found files is saved in '$mp3files' file.' >> $result
echo  >> $result

# COMPLETED - audio files size evaluation

# INIT - Video files search

echo 'Start search for video files...' >> $result
echo  >> $result
for i in "${arry[@]}"
do
   echo "Search for video files in $i ..." >> $result
   find $i -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p' > $videofiles
   echo   >> $result
   echo 'Files found...' >> $result
   echo '___________________________________________________________' >> $result
done
echo 'Finished search for video files. Results are saved in '$videofiles >> $result
echo '___________________________________________________________' >> $result
echo >> $result
# COMPLETED - Video files search

# INIT - Video files size evaluation

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

# COMPLETED - Video files size evaluation

echo 'medialocator results are saved in '$result' file.'

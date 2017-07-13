#!/bin/bash
# Files locator

# INIT - initation sequence
Date=$(date +"%Y-%m-%d_%H%M%S")

clear

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
echo
echo
echo 'How many years back are we looking at?'
echo '======================='
read years
echo 'thanks'
TARGET="$(($(date +%Y)-$years))-$(date +%m)-$(date +%d)"
echo 'I`ll try to find all files created prior to: ' $TARGET
echo
echo '=================================================='
echo


if [ ! -d results ]; then
  mkdir -p results;
  else
  if [ "$(ls -A results)" ]; then
    rm -r results/*
    if [ $? -eq 0 ]; then
      echo 'deleted old results files';
      else echo 'failed to delete old result files'
      exit 1
    fi
  fi
fi

result="results/result_$Date.txt"
files="results/filesToProcess.txt"

diff () {
        printf '%s' $(( $(date +%s) -
                        $(date -u -d"$TARGET" +%s)))
#                       %d = day of month.
}

MPHR=60    # Minutes per hour.
HPD=24     # Hours per day.

# %F = full date, %T = %H:%M:%S, %N = nanoseconds, %Z = time zone.
# echo "Result between "$TARGET" and "$(date +%F)" is: " $(diff)

echo 'Files locator initiates...' > $result
echo 'Date: '$Date >> $result

# COMPLETED - initiation sequence

# INIT - Files search

echo 'Start search for files...' >> $result
for i in "${arry[@]}"
do
   echo "Search for files in $i ..." >> $result
#   find $i -type f -iname "*" >> $files
   DAYS=$(( $(diff) / $MPHR / $MPHR / $HPD ))
   echo 'number of days: '$DAYS
   find $i -type f -mtime +$DAYS >> $files
   echo >> $result
   echo 'Files found...' >> $result
   echo '___________________________________________________________' >> $result
done

echo 'Finished search for files. Results are saved in '$files >> $result
echo '___________________________________________________________' >> $result
echo >> $result

# COMPLETED - Files search

# INIT - Files size evaluation

echo 'Starting size evaluation...' >> $result
echo 'Size evaluation:' >> $result

size=0
num=0
list=$files
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
while read -r list || [[ -n "$list" ]];
do
    ((num++))

    sizetemp=$(stat -c "%s" "$list")
    size=$(($size+$sizetemp))

done <  "$list"
IFS=$SAVEIFS

size=$(($size/1024/1024))
echo 'Total size of found files in '$list': '$size' MB' >> $result
echo '-------------------------------------------------------' >> $result
echo 'List of '$num' found files is saved in '$list' file.' >> $result
echo  >> $result

# COMPLETED - Files size evaluation

echo 'filesLocator results are saved in '$result' file.'
echo 'Files found by filesLocator are saved in '$files' file.'

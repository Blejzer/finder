#!/bin/bash
temp="./temp.txt"
find results/ -maxdepth 1 -type f > $temp

if [[ -s "$temp" ]]; then
  more "$temp"
else
  echo "Folder provided is empty. Please provide folder with list of files to be processed"
  exit 1
fi

list=$temp

declare -a arry=()
echo ${#arry[@]}
numb=1
echo "Please select file from the list by entering the number of the file: "
echo
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
while read -r list || [[ -n "$list" ]];
do
  arry+=("$list")
  echo "$numb: ""$list"
  ((numb++))
done <  "$list"

echo "Your choice: "
read choice
# echo ${#arry[@]}
((choice--))
result="./destroyerResults_$Date.txt"
exefiles=${arry[choice]}
echo "$exefiles"

rm $temp

echo 'filesProcessor initiates...' > $result
echo 'Date: '$Date >> $result
list=$exefiles
num=0

echo "what do you want to do with the files?"
echo "-------------------------------------"
echo "1. Delete (Remove forever)"
echo "2. Copy"
echo "3. Move (Copy and Delete)"
echo "-------------------------------------"
echo
echo "Please select number of the action: "
echo
read selector
action=""
if (( selector == 1 )); then
  action="rm"
elif [[ $selector -eq 2 ]]; then
  action="cp"
else
  action="mv"
fi
echo "You selected $action to be performed"
echo
# Get the destination folder and check if it is a folder
until [[ -d "$destination" ]]; do
  echo "Please insert correct folder path:"
  read  destination
done

echo "$destination"

exit 1

echo 'Processing with $action everything in '$list >> $result
while read -r list || [[ -n "$list" ]];
do
    ((num++))
    echo 'trying to process: ' "${list}" >> $result

    rmResult=$($action "${list}" results/)
    if [[ $rmResult ]];
    then
      echo '$action OK' >> $result
    else
      echo 'Result of individual $action: '$rmResult >> $result
    fi

done <  "$list"
IFS=$SAVEIFS

echo '-------------------------------------------------------' >> $result
echo 'List of '$num' files removed.' >> $result
echo '-------------------------------------------------------' >> $result
echo  >> $result

# finder
bash script for finding and counting files. medialocator fill find mp3 files and any video file. fileLocator is finding files older than date you provide it with.

1. make sure that you have permissions for running this file, and that the file has proper permissions.

2. you can enter any number of folders to be scanned, just make sure that the path is correct, and that each is separated by space. (/opt/samba/ /home/ ~/Library/)  

3. medialocator.sh will create 3 separate files in folder results that it will attempt to create in the same location where it runs from.
result_$Date.txt - result of the scanning process
mp3files_$Date.txt - list of found mp3 files
videofiles_$Date.txt - list of found video files

4. fileLocator.sh will accept folder locations in same way as medialocator does.

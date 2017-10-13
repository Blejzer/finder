# Files finder
Bash script for finding files, writing their list and counting their number and total size.


## General description

These scripts are intended to help administrators save time finding and removing old files, music and video content, that usually takes a lot of storage space, especially, like in my case, on my file server.

### Getting Started

Do you have to go through the file servers and deduce what is eating most of their space. Sometimes, older files need to be archived or removed, but most of the time, its media (audio / video) files that cause a lot of problems.
Two scripts, for now, are made to help admins locate certain types of files to assess their size and location, to help them make correct decisions and plans regarding cleanups and assessments regarding space on their servers.  
Scripts will search through the folders you provide recursively, save the found content that meets the criteria and save the results in one file and the list of files in another ones.
Later, you can use filesProcessor script and Remove, Copy or Move files to another location... Just feed it with the file containing the list and it's done.


## Prerequisites

All you need is your administrators' mana to be at lvl 3. :D
Make sure that you have right permissions for executing these files, and that the files have proper permissions:

```
chmod +x filename.sh
```
so you will be able to run it.


## Running scripts

First you need to execute the script
```
./filename.sh
```
Then, both scripts will ask you to provide all of the destinations you want it to scan
```
Hello, please enter absolute path to folders you need scanned (/test/ /opt/samba/ /public/ ...):
```
You can provide any number of paths to be scanned. Just make sure that the path is correct, and that each is separated by space.
```
/home/user/Documents/ /opt/samba/profiles/
```

medialocator does not require any additional information and it will start scanning provided folders, where filesLocator will have one more step, it will ask you for the number of years that is the minimum age of the files to look for
```
How many years back are we looking at?
=======================
```


## filesLocator.sh - desc

filesLocator is a script that scans folders and find files that are older then number of years you require. It records their absolute paths and tries to determine their size and calculates total size of all found files.

Once started, filesLocator script has two steps.
In the first one, it will create folder `results` where results will be saved, and try to find all files at destinations you provide, that are older than number of years you provide.
Results will be saved in
```
results/filesToProcess_$Date.txt # $Date is the datetime value of the moment the script is executed
```
and they are ordered by their location.

In the second step, it will read all of the files from the filesToProcess file and try to determine their individual size and calculate total size of all of the files it found.

All of the steps are recorded and saved in
```
results/results_$Date.txt  # same as above
```


## medialocator.sh - desc

medialocator.sh is a script that scans folder and finds files that are of media type (audio, and video files)
medialocator.sh will create 3 separate files in folder results that it will attempt to create in the same location where it runs from.
result_$Date.txt - result of the scanning process
mp3files_$Date.txt - list of found mp3 files
videofiles_$Date.txt - list of found video files


## Thoughts, comments, and issues

I welcome, and encourage you to share your ideas, open issues (please be detailed about it), and of course, comments. I will keep this project alive, as it is both fun and useful, so I will add new stuff to it, and maybe few more functionalities as well.


## Author

* **Nikola Kujaca** - *Initial work* - [BDS Lab](http://www.bdslab.info)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

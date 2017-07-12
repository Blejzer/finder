# Files finder
Bash script for finding files and counting their number and  total size

## Getting Started

These scripts are intended to help administrators save time finding and removing old files, music and video content, that usually takes a lot of storage space, especially, like in my case, on my file server.

### Prerequisites

All you need is your administator's mana to be at lvl 3. :D
Make sure that you have permissions for executing these file, and that the file has proper permissions:

```
chmod +x filename.sh
```
so you will be able to run it.

### Running scripts

First you need to execute the script
```
./filename.sh
```
Then, both scripts will ask you to provide all of the destinations you want it to scan
```
Hello, please enter absolute path to folders you need scanned (/test/ ~/Library/ /opt/samba/):
```
You can provide any number of paths to be scanned. Just make sure that the path is correct, and that each is separated by space.
```
/home/user/Documents/ /opt/samba/profiles/ ~/Library/
```

medialocator does not require any additional information and it will start scanning provided folders, where filesLocator will have one more step, it will ask you for the number of years that is the minimum age of the files to look for
```
How many years back are we looking at?
=======================
```

### filesLocator.sh - desc

filesLocator is a script that scans folders and find files that are older then number of years you require. It records their absolute paths and tries to determine their size and calculates total size of all found files.

Once started, filesLocator script has two steps.
In the first one, it will create folder `results` where results will be saved, and try to find all files at destinations you provide, that are older than number of years you provide.
Results will be saved in
```
results/filesToProcess.txt
```
and they are ordered by their location.

In the second step, it will read all of the files from the filesToProcess file and try to determine their individual size and calculate total size of all of the files it found.

All of the steps are recorded and saved in
```
results/results_$Date.txt  # $Date is the datetime value of the moment the script is executed
```


### medialocator.sh - desc

medialocator.sh will create 3 separate files in folder results that it will attempt to create in the same location where it runs from.
result_$Date.txt - result of the scanning process
mp3files_$Date.txt - list of found mp3 files
videofiles_$Date.txt - list of found video files




## Authors

* **Nikola Kujaca** - *Initial work* - [BDS Lab](http://www.bdslab.info)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

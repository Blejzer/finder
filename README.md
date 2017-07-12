<<<<<<< HEAD
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

```
./filename.sh
```

### filesLocator.sh - desc

filesLocator script has two steps.
In the first one, it will try to find all files at destinations you provide, that are older than number of years you provide.
Results will be saved in the
```
results/filesToProcess.txt
```
In the second step, it will read all of the files from the filesToProcess file and try to determine their individual size and calculate total size of all of the files it found.
=======
# finder
bash script for finding and counting files. medialocator fill find mp3 files and any video file. fileLocator is finding files older than date you provide it with.
>>>>>>> 4b7f10fe7cd9689df2d4011dc710125da8e73a4e


2. you can enter any number of folders to be scanned, just make sure that the path is correct, and that each is separated by space. (/opt/samba/ /home/ ~/Library/)  

3. medialocator.sh will create 3 separate files in folder results that it will attempt to create in the same location where it runs from.
result_$Date.txt - result of the scanning process
mp3files_$Date.txt - list of found mp3 files
videofiles_$Date.txt - list of found video files

4. fileLocator.sh will accept folder locations in same way as medialocator does.





### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

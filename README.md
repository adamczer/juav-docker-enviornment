This is a dockerized setup for running the jUAV code base

The use of Fiji MVM requires that the binaries be build to 32 bit

To allow simplifiy the development process and allow the use of standard machines with Docker

once Docker is installed you can build this deployment using the build script

in the build directory you will need to have a checkout of Fiji:

> git clone <some-fiji-repo> Fiji-VM-JUAV

you also need a copy of jdk-7u80-linux-i586.tar.gz, and save it in the build/files/jdk-7u80-linux-i586.tar.gz. This can be aquired from oracle https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html

upon completion you can use the enter the env folder to run:

check out JUAV to this folder JUAV-ardupilot

you may put a current checkout of the ardupilot in the folder at ardupilot or the baseline will be extracted from the container.

to run simply run ./runEnviornment.sh

in the container you can use the scripts/* to run the various functions, their outputs will be placed in the created output dir in the host machine. 
 

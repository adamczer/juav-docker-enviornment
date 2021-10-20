#!/bin/bash
if [ ! -d /home/juav/ardupilot ]; then
    ln -s /home/juav/ardupilot-original /home/juav/ardupilot;
fi;
. ~/.profile
cd JUAV-ardupilot
mvn install -Dhttps.protocols=TLSv1.2
cd juav-native/juav-native-ardupilot/jni/
mkdir -p lib
make sitl
cd ../../../juav-hal/juav-hal-sitl/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libArduCopterSitl.so /usr/lib/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libJuavSitlJni.so /usr/lib/
sudo ldconfig
xterm -e sim_vehicle.py -v ArduCopter --console --map &
date
set -m
./run-juav-copter.sh $1 &
fg
date
thisRun=`date '+%Y-%m-%d-%H-%M-%S'`
mkdir -p /home/juav/output/${thisRun}-java-$1
mv *.log /home/juav/output/${thisRun}-java-$1/

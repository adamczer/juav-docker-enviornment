#!/bin/bash
if [ ! -d /home/juav/ardupilot ]; then
    ln -s /home/juav/ardupilot-original /home/juav/ardupilot;
fi;
#sed -i "s/memset/\/\/memset/g" /home/juav/ardupilot/libraries/AP_Mount/SoloGimbalEKF.cpp
. ~/.profile
cd ~/JUAV-ardupilot
mvn install -Dhttps.protocols=TLSv1.2
cd native-util/jni
make sitl
sudo ln -s /home/juav/JUAV-ardupilot/native-util/jni/lib/libNativeUtil.so /usr/lib/
cd ../../juav-native/juav-native-ardupilot/jni/
mkdir -p lib
make sitl
cd ../../../juav-hal/juav-hal-sitl/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libArduCopterSitl.so /usr/lib/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libJuavSitlJni.so /usr/lib/
sudo ldconfig
./build-juav-fiji.sh

xterm -e sim_vehicle.py -v ArduCopter --console --map &
cd juav-fiji
cp /usr/lib/*Sitl* .
date
set -m
#sudo -E ./JuavFiji fiji &
#sudo -E taskset -c 0-3 ./JuavFiji fiji $1 &
sudo -E taskset -c 0 ./JuavFiji fiji $1 &
fg
date
thisRun=`date '+%Y-%m-%d-%H-%M-%S'`
mkdir -p /home/juav/output/${thisRun}-fiji-$1
mv *.log /home/juav/output/${thisRun}-fiji-$1/

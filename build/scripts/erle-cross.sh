#!/bin/bash
if [ ! -d /home/juav/ardupilot ]; then
    ln -s /home/juav/ardupilot-original /home/juav/ardupilot;
fi;
. ~/.profile
cd JUAV-ardupilot
mvn install -Dhttps.protocols=TLSv1.2
cd juav-native/juav-native-ardupilot/jni/
make erle
cd ../../../juav-hal/juav-hal-erle-copter/

sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libArduCopterErleCopter.so /usr/lib/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libJuavErleCopterJni.so /usr/lib/
sudo ldconfig
./build-juav-fiji.sh
thisRun=`date '+%Y-%m-%d-%H-%M-%S'`
mkdir -p /home/juav/output/erle-binaries
rm -rf /home/juav/output/erle-binaries/*
mv juav-fiji/* /home/juav/output/erle-binaries/
rm -rf /home/juav/output/erle-binaries/JuavFiji.build

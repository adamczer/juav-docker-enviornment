#!/bin/bash
if [ ! -d /home/juav/ardupilot ]; then
    ln -s /home/juav/ardupilot-original /home/juav/ardupilot;
fi;
. ~/.profile
cd JUAV-ardupilot
mvn clean install -Dhttps.protocols=TLSv1.2
cd juav-native/juav-native-ardupilot/jni/
make sitl
cd ../../../juav-hal/juav-hal-sitl/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libArduCopterSitl.so /usr/lib/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libJuavSitlJni.so /usr/lib/
sudo ldconfig
./build-juav-fiji-mvm.sh
cd juav-fiji-mvm
cp /usr/lib/lib*Sitl*.so .
xterm -e sim_vehicle.py -v ArduCopter --console --map &
set -m
sudo -E ./mvm &
fg
thisRun=`date '+%Y-%m-%d-%H-%M-%S'`
mkdir -p /home/juav/output/${thisRun}-java
mv *.log /home/juav/output/${thisRun}-java/

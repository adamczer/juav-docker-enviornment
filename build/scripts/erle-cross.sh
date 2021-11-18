#!/bin/bash
if [ ! -d /home/juav/ardupilot ]; then
    ln -s /home/juav/ardupilot-original /home/juav/ardupilot;
fi;
. ~/.profile
cd JUAV-ardupilot
mvn install -Dhttps.protocols=TLSv1.2
cd native-util/jni
make erle
sudo ln -s /home/juav/JUAV-ardupilot/native-util/jni/lib/libNativeUtil.so /usr/lib/
cd ../../juav-native/juav-native-ardupilot/jni/
mkdir -p lib
make erle
cd ../../../juav-hal/juav-hal-erle-copter/

# Copy java binaries
mkdir -p /home/juav/output/erle-binaries/java
rm -rf /home/juav/output/erle-binaries/java/*
cp target/*with-dependencies.jar /home/juav/output/erle-binaries/java/
cp /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libArduCopterErleCopter.so /home/juav/output/erle-binaries/java/
cp /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libJuavErleCopterJni.so /home/juav/output/erle-binaries/java/
cp /home/juav/JUAV-ardupilot/native-util/jni/lib/libNativeUtil.so /home/juav/output/erle-binaries/java/

# build fiji
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libArduCopterErleCopter.so /usr/lib/
sudo ln -s /home/juav/JUAV-ardupilot/juav-native/juav-native-ardupilot/jni/lib/libJuavErleCopterJni.so /usr/lib/
sudo ldconfig
./build-juav-fiji.sh

# Copy fiji binaries
mkdir -p /home/juav/output/erle-binaries/fiji
rm -rf /home/juav/output/erle-binaries/fiji/*
mv juav-fiji/* /home/juav/output/erle-binaries/fiji/
rm -rf /home/juav/output/erle-binaries/fiji/JuavFiji.build

# Copy latest ardupilot

mkdir -p /home/juav/output/erle-binaries/ardupilot
rm -rf /home/juav/output/erle-binaries/ardupilot/*
cp /home/juav/ardupilot/build/erlebrain2/bin/arducopter /home/juav/output/erle-binaries/ardupilot/
#mkdir -p /home/juav/output/erle-binaries/ardupilot/lib
#cp /usr/arm-linux-gnueabihf/lib/libm.so.6 /home/juav/output/erle-binaries/ardupilot/lib
# run with LD_LIBRARY_PATH=<libdir> ./arducopter ...

# mvm 

./build-juav-fiji-mvm.sh
mkdir -p /home/juav/output/erle-binaries/mvm
rm -rf /home/juav/output/erle-binaries/mvm/*
mv juav-fiji-mvm/* /home/juav/output/erle-binaries/mvm/
rm -rf /home/juav/output/erle-binaries/mvm/*.build
rm -rf /home/juav/output/erle-binaries/mvm/*.a



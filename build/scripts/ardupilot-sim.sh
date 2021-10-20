#!/bin/bash
if [ ! -d /home/juav/ardupilot ]; then
    ln -s /home/juav/ardupilot-original /home/juav/ardupilot;
fi;
. ~/.profile
sim_vehicle.py -v ArduCopter --console --map 
thisRun=`date '+%Y-%m-%d-%H-%M-%S'`
mkdir -p /home/juav/output/${thisRun}-ardu
mv *.log /home/juav/output/${thisRun}-ardu/

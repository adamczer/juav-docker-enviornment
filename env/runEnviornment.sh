#!/bin/bash
mkdir -p m2
if [ ! -d ardupilot ]; then
  mkdir ardupilot
  docker run --platform linux/386 -it -v $PWD/ardupilot:/home/juav/ardupilot --entrypoint /bin/bash juav-docker -c 'cp -r /home/juav/ardupilot-original/* /home/juav/ardupilot/'
fi

docker run --privileged --platform linux/386 -it --rm -e DISPLAY=${DISPLAY} -v $PWD/JUAV-ardupilot:/home/juav/JUAV-ardupilot -v $PWD/m2:/home/juav/.m2 -v $PWD/ardupilot:/home/juav/ardupilot -v $PWD/output:/home/juav/output -v /tmp/.X11-unix:/tmp/.X11-unix juav-docker

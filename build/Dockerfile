#ubutu 18 32 bit
FROM ubuntu:18.04@sha256:d3b8b26602942b6e87976d8f77a01a2d8fcd5e7ee7ec7713ec6cf8990866086a
ARG DEBIAN_FRONTEND=noninteractive
ENV JUAV_SRC=/home/juav/JUAV-ardupilot
ENV ARDU_SRC=/home/juav/ardupilot
ENV FIJI_HOME=/home/juav/Fiji-VM-JUAV
ENV JAVA_HOME=/home/juav/jdk1.7.0_80/
ENV ARM_GCC=/home/juav/gcc-linaro
ENV PATH=$ARM_GCC/bin:$JAVA_HOME/bin:$PATH:$HOME/bin:$ARDU_SRC/Tools/scripts
RUN useradd -ms /bin/bash juav
RUN apt-get update && apt-get install -y wget sudo git gitk git-gui maven lsb-release software-properties-common ruby time vim gdb
RUN adduser juav sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER juav
WORKDIR /home/juav
RUN wget https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabihf.tar.xz && \
tar xf gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabihf.tar.xz && mv gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabihf gcc-linaro && \ 
rm gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabihf.tar.xz
RUN git clone https://github.com/ArduPilot/ardupilot.git && \
cd ardupilot && \
git checkout 22c9081c8325ec8d980906fe7b1d23f29080a216 && \
git submodule update --init --recursive
RUN sed -i "s/MACHINE_TYPE=.*/MACHINE_TYPE=i386/g" ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh && export USER=juav && ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y

RUN mv ardupilot ardupilot-original


COPY Fiji-VM-JUAV /home/juav/Fiji-VM-JUAV-orig
RUN cp -r /home/juav/Fiji-VM-JUAV-orig /home/juav/Fiji-VM-JUAV

COPY files /home/juav/files

RUN tar xf files/jdk-7u80-linux-i586.tar.gz

RUN cd Fiji-VM-JUAV && \
sed -i '1739i // fall through\n' runtimec/src/fivmr_cmrgc.c && \
sed -i "s/adamczer\/mvm-yin\/fivm/juav\/Fiji-VM-JUAV/g" scj/oSCJ/scj/ri/config.status && \
sed -i "s/adamczer\/mvm-yin\/fivm/juav\/Fiji-VM-JUAV/g" scj/oSCJ/scj/ri/config.log && \
autoreconf -i && \
./configure --build=i386 --host=i386 --target=i386 && \
make && \
bin/add-target --cc /usr/bin/arm-linux-gnueabihf-gcc --posix --host arm-linux-gnueabihf --ptr-size 32 && \
make

COPY scripts /home/juav/scripts

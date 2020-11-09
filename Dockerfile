FROM debian:buster
MAINTAINER holishing
COPY build.bash /build.bash
RUN useradd -ms /bin/bash builduser \
    && ( echo 'deb http://deb.debian.org/debian buster-backports main' | tee -a /etc/apt/sources.list ) \
    && cat /etc/apt/sources.list \
    && apt-get update \
    && apt-get -t buster-backports upgrade -y \
    && apt-get -t buster-backports install -y build-essential devscripts sudo \
    && cp /etc/sudoers /tmp/sudoers.backup \
    && ( echo 'builduser ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo ) \
    && sudo -iu builduser bash -l /build.bash \
    && cp -v /home/builduser/debuild/flatbuffers-compiler_*.deb /home/builduser/debuild/libflatbuffers1_*.deb \
             /home/builduser/debuild/flatbuffers-compiler-dev_*.deb /home/builduser/debuild/libflatbuffers-dev_*.deb /tmp/ \
    && apt-get -t buster-backports install -y /tmp/*.deb \
    && apt-get purge -y build-essential devscripts flatbuffers-build-deps \
    && apt-get autoremove -y \
    && ( cat /tmp/sudoers.backup | sudo EDITOR='tee' visudo ) \
    && userdel -rf builduser

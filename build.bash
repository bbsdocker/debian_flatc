#!/usr/bin/env bash

set -eux

export BUILD_DIR=${HOME}/debuild

/usr/bin/env | tee /home/builduser/env.log

git clone https://salsa.debian.org/debian/flatbuffers.git ${BUILD_DIR}/flatbuffers

cd ${BUILD_DIR}/flatbuffers
mk-build-deps debian/control
sudo apt-get -t buster-backports install -y ./*.deb
rm -rfv *.deb
debuild -b -us -uc -rfakeroot
fakeroot debian/rules clean

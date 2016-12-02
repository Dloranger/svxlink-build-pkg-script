#!/bin/bash

#Set Pkg Build Version
PKG_NAME=svxlink
PKG_VER=14.10.8
BUILD=1

#set repo info
REPO=/home/repo/$PKG_NAME/debian
WRK_DIR=/usr/src/"$PKG_NAME"-build

#remove old build dir
rm 14*
rm -rf $WRK_DIR

#Set Timestamp in the change logs
TIME=$(date +"%a, %d %b %Y %X")

#Get the main src
wget https://github.com/kb3vgw/svxlink/archive/$PKG_VER.tar.gz

#Build svxlink

mkdir $WRK_DIR

tar xzvf $PKG_VER.tar.gz -C $WRK_DIR

cd $WRK_DIR/$PKG_NAME-$PKG_VER

dch -v $PKG_VER-$BUILD

cd $WRK_DIR/$PKG_NAME-$PKG_VER

uscan --download-current-version

cd $WRK_DIR/$PKG_NAME-$PKG_VER

time dpkg-buildpackage -rfakeroot -i -us -uc

cd $WRK_DIR

mkdir debs-svxlink-$PKG_VER

mv *.deb debs-$PKG_NAME-$PKG_VER
mv *.changes debs-$PKG_NAME-$PKG_VER
mv *.xz debs-$PKG_NAME-$PKG_VER
mv *.dsc debs-$PKG_NAME-$PKG_VER

#cp -rp "$WRK_DIR"/debs-$PKG_NAME/* "$REPO"/incoming
#cd "$REPO" && ./import-new-pkgs.sh



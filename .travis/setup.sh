#!/bin/bash

set -eufo pipefail

NINJA_VERSION="1.8.2"

source .travis/platform.sh

mkdir -p $HOME/bin

if [ "$PLATFORM" == "macosx" ]; then
  NINJA_ZIP=ninja-mac.zip
  CC=clang
  CXX=clang++
elif [ "$PLATFORM" == "cygwin" ]; then
  NINJA_ZIP=ninja-win.zip
  CC=gcc
  CXX=g++
elif [ "$PLATFORM" == "linux" ]; then
  NINJA_ZIP=ninja-linux.zip
  CC=gcc
  CXX=g++

  sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
  sudo apt-get update -qq
  sudo apt-get install -qq gcc-5 g++-5 gcc-5-multilib g++-5-multilib
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 70 --slave /usr/bin/g++ g++ /usr/bin/g++-5
  sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
  sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
  sudo update-alternatives --set cc /usr/bin/gcc
  sudo update-alternatives --set c++ /usr/bin/g++
  sudo update-alternatives --set gcc /usr/bin/gcc-5
fi

if [ -n "$NINJA_ZIP" ]; then
  wget https://github.com/ninja-build/ninja/releases/download/v$NINJA_VERSION/$NINJA_ZIP
  unzip -d $HOME/bin $NINJA_ZIP
  rm -f $NINJA_ZIP
fi

echo "$CC --version" && $CC --version
echo "$CXX --version" && $CXX --version
echo "ninja --version" && ninja --version

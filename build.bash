#! /bin/bash

echo Remove old build directory
rm -rf build
echo Copy src checkout to build
svn export src build

echo Create build tools
cd build/tools/jam
./build_dist.sh
cd ../..
cp -v ./build/tools/jam/src/bin.linuxx86_64/bjam ~/bin/

echo Configure then make
./configure
make all

echo Installing
rm -rf ../../dist/boost
bjam --toolset=gcc --prefix ../../dist/boost install

echo Ending
cd ..

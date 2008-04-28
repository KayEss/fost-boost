#! /bin/bash

echo Remove old build direcotry
rm -r build
echo Copy src checkout to build
svn export src build

echo Create build tools
cd build/tools/jam
./build_dist.sh
cd ../..

echo Configuring
./configure

echo Ending
cd ..

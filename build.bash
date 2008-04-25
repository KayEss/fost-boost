#! /bin/bash

# Create build structure
rm -r build
svn export src build

# Create build tools
cd build/tools/jam
./build_dist.sh
cd ../../..


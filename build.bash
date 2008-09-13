#! /bin/bash

cd src

if test ! -e ~/bin/bjam
then {
        echo Create build tools
        cd tools/jam
        ./build_dist.sh
        cd ../..
        if test -e ./build/tools/jam/src/bin.linuxx86_64/bjam
        then {
            cp -v ./build/tools/jam/src/bin.linuxx86_64/bjam ~/bin/
        } else {
            cp -v ./build/tools/jam/src/bin.linuxx86/bjam ~/bin/
        }
        fi
}
fi

echo Configure then make
./configure
make all

rm -rf ../install
bjam --toolset=gcc --prefix=../install install --without-mpi

cd ..

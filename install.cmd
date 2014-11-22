@echo off
pushd %0\..

copy "%3\1_%1_%2\bjam.exe" ..

del ..\boost-build.jam
cmd /A /C echo BOOST_ROOT = $(.boost-build-file:D) ;>> ..\boost-build.jam
cmd /A /C echo BOOST_BUILD = [ MATCH --boost-build=(.*) : $(ARGV) ] ;>> ..\boost-build.jam
if %1 LSS 56 cmd /A /C echo BOOST_BUILD ?= Boost/%3/../Boost/1_%1_%2/tools/build/v2 ;>> ..\boost-build.jam
if %1 GTR 55 cmd /A /C echo BOOST_BUILD ?= Boost/%3/../Boost/1_%1_%2/tools/build/src ;>> ..\boost-build.jam
cmd /A /C echo boost-build $(BOOST_BUILD) ;>> ..\boost-build.jam

del ..\boost-version.jam
cmd /A /C echo BOOST_VERSION_MAJOR = "%1" ;>> ..\boost-version.jam
cmd /A /C echo BOOST_VERSION_MINOR = "%2" ;>> ..\boost-version.jam
cmd /A /C echo BOOST_HEADERS = "../Boost/%3/../Boost/boost/include/boost-1_$(BOOST_VERSION_MAJOR)/" ;>> ..\boost-version.jam
cmd /A /C echo BOOST_LIBS = "../Boost/%3/../Boost/boost/lib" ;>> ..\boost-version.jam
cmd /A /C echo BUILD_DIRECTORY = "../build.tmp/1_%1_%2" ;>> ..\boost-version.jam

cmd /A /C echo set BUILD_DIRECTORY=../build.tmp/1_%1_%2> ..\boost-version.cmd
cmd /A /C echo set BOOST_VERSION_MAJOR=%1 >> ..\boost-version.cmd
cmd /A /C echo set BOOST_VERSION_MINOR=%2 >> ..\boost-version.cmd

copy Jamroot.ownbuild-versioned-layout Jamroot

popd

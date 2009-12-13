@echo off
copy 1_%1_%2\bjam.exe ..

del ..\boost-build.jam
cmd /A /C echo BOOST_ROOT = $(.boost-build-file:D) ;>>..\boost-build.jam
cmd /A /C echo BOOST_BUILD = [ MATCH --boost-build=(.*) : $(ARGV) ] ;>>..\boost-build.jam
cmd /A /C echo BOOST_BUILD ?= Boost/1_%1_%2/tools/build/v2 ;>>..\boost-build.jam
cmd /A /C echo boost-build $(BOOST_BUILD) ;>>..\boost-build.jam

del ..\boost-version.jam
cmd /A /C echo BOOST_VERSION_MAJOR = "%1" ;>> ..\boost-version.jam
cmd /A /C echo BOOST_VERSION_MINOR = "%2" ;>> ..\boost-version.jam
cmd /A /C echo BOOST_HEADERS = "../Boost/boost/include/boost-1_$(BOOST_VERSION_MAJOR)/" ;>> ..\boost-version.jam
cmd /A /C echo BUILD_DIRECTORY = "../build.tmp/1_%1_%2" ;>> ..\boost-version.jam

cmd /A /C echo set BUILD_DIRECTORY=../build.tmp/1_%1_%2>> ..\boost-version.cmd

copy Jamroot.ownbuild-1_39_0-or-earlier Jamroot

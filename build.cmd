@echo off
pushd %0\..

IF "%1"=="" (
    SET MAJOR=62
) ELSE (
    SET MAJOR=%1
)
IF "%2"=="" (
    SET MINOR=0
) ELSE (
    SET MINOR=%2
)

IF "%3"=="" (
    SET LOCATION=.
) ELSE (
    SET LOCATION=%3
)

IF NOT EXIST boost-build/bjam.exe (
    pushd boost-build
    call bootstrap.bat
    popd
)

SET VERSION=1_%MAJOR%_%MINOR%

IF NOT EXIST %VERSION% (
    python -c "from urllib import urlretrieve; urlretrieve('http://sourceforge.net/projects/boost/files/boost/1.%MAJOR%.%MINOR%/boost_%VERSION%.zip/download', '%VERSION%.zip')"
    python -c "from zipfile import ZipFile; ZipFile('%VERSION%.zip').extractall()"
    REN boost_%VERSION% %VERSION%
)
COPY boost-build\bjam.exe %VERSION%
del %VERSION%\boost-build.jam
cmd /A /C echo BOOST_ROOT = $(.boost-build-file:D) ;>> %VERSION%\boost-build.jam
cmd /A /C echo BOOST_BUILD = [ MATCH --boost-build=(.*) : $(ARGV) ] ;>> %VERSION%\boost-build.jam
cmd /A /C echo BOOST_BUILD ?= ../boost-build/src ;>> %VERSION%\boost-build.jam
cmd /A /C echo boost-build $(BOOST_BUILD) ;>> %VERSION%\boost-build.jam


call compile.cmd %VERSION%

IF "%1"=="" (
    call install.cmd %MAJOR% %MINOR% %LOCATION%
) ELSE (
    echo To use this version run:
    echo cd %0\..
    echo install.cmd %MAJOR% %MINOR% %LOCATION%
)
popd

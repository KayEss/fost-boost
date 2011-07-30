@echo off
pushd %0\..
svn up .

IF "%1"=="" (
    SET MAJOR=41
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

SET VERSION=1_%MAJOR%_%MINOR%

IF NOT EXIST %VERSION% (
    svn co http://svn.boost.org/svn/boost/tags/release/Boost_%VERSION% %VERSION%
)
IF NOT EXIST %VERSION%\bjam.exe (
    cd %VERSION%
    svn up
    IF EXIST bootstrap.bat (
        call bootstrap.bat
    ) ELSE (
        cd tools\jam
        call build_dist.bat
        copy bin.ntx86\bjam.exe ..\..\..
        cd ..\..\..
    )
    cd ..
)

call compile.cmd %VERSION%

IF "%1"=="" (
    call install.cmd %MAJOR% %MINOR% %LOCATION%
) ELSE (
    echo To use this version run:
    echo cd %0\..
    echo install.cmd %MAJOR% %MINOR% %LOCATION%
)
popd

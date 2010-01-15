@echo off
svn up .
IF "%1"=="" (
    SET MAJOR=38
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
IF NOT EXIST "%LOCATION%\%VERSION%" (
    IF NOT EXIST %VERSION% (
        svn co http://svn.boost.org/svn/boost/tags/release/Boost_%VERSION% %VERSION%
    ) ELSE (
	    svn up %VERSION%
    )
    IF NOT EXIST %VERSION%\bjam.exe (
        cd %VERSION%\tools\jam
        call build_dist.bat
        cd
        copy bin.ntx86\bjam.exe ..\..\..
        cd ..\..\..\..
    )
    call compile.cmd %VERSION%
)

echo To use this version run:
echo install.cmd %MAJOR% %MINOR% %LOCATION%

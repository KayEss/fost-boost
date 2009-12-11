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
SET VERSION=1_%MAJOR%_%MINOR%
IF NOT EXIST %VERSION% (
    svn co http://svn.boost.org/svn/boost/tags/release/Boost_%VERSION% %VERSION%
)
IF NOT EXIST %VERSION%\bjam.exe (
    cd %VERSION%\tools\jam
    call build_dist.bat
    cd
    copy bin.ntx86\bjam.exe ..\..\..
    cd ..\..\..\..
)
call compile.cmd %VERSION%
call install.cmd %MAJOR% %MINOR%

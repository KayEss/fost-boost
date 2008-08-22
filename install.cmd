
rmdir /s /q ..\include\boost
xcopy /e /i /y /q install\include\boost-1_35\boost ..\include\boost

del ..\bin\boost_*.dll
del ..\bin\boost_*.lib
del ..\bin\libboost*.lib
xcopy /e /i /y /q install\lib ..\bin

xcopy /y /q src\bjam.exe ..

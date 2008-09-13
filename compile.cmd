cd src\tools\jam
call build_dist.bat
copy boost-jam-3.1.16-1-ntx86\bjam.exe ..\..\..
cd ..\..\..
bjam -j3 --toolset=msvc-8.0 define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE define=_CRT_SECURE_NO_WARNINGS tools --asynch-exceptions=on --exception-handling=on --extern-c-nothrow=off
bjam -j3 --toolset=msvc-8.0 define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE define=_CRT_SECURE_NO_WARNINGS debug release runtime-link=shared threading=multi --prefix=..\install --asynch-exceptions=on --exception-handling=on --extern-c-nothrow=off install
cd ..

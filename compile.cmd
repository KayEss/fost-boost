cd src\tools\jam
call build_dist.bat
copy boost-jam-3.1.16-1-ntx86\bjam.exe ..\..\..
cd ..\..\..
bjam --toolset=msvc-8.0 tools
bjam -j3 --toolset=msvc-8.0 --prefix=..\install define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE debug release runtime-link=shared threading=multi install
cd ..

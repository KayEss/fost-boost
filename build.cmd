cd src\tools\jam
call build_dist.bat
copy boost-jam-3.1.16-1-ntx86\bjam.exe ..\..\..
cd ..\..\..
bjam --toolset=msvc-8.1 tools
bjam --toolset=msvc-8.1 --prefix=..\install\basic debug release runtime-link=shared threading=multi install --without-python

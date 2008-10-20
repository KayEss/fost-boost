cd %1\tools\jam
call build_dist.bat
copy bin.ntx86\bjam.exe ..\..\..
cd ..\..\..
bjam -j%NUMBER_OF_PROCESSORS% --toolset=msvc-8.0 define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE define=_CRT_SECURE_NO_WARNINGS tools asynch-exceptions=on exception-handling=on extern-c-nothrow=off
bjam -j%NUMBER_OF_PROCESSORS% --toolset=msvc-8.0 define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE define=_CRT_SECURE_NO_WARNINGS debug release install runtime-link=shared threading=multi asynch-exceptions=on exception-handling=on extern-c-nothrow=off --prefix=..\install
cd ..

cd %VERSION%
bjam -j%NUMBER_OF_PROCESSORS% toolset=msvc-8.0 define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE define=_CRT_SECURE_NO_WARNINGS --without-mpi release tools runtime-link=shared link=shared threading=multi asynch-exceptions=on exception-handling=on extern-c-nothrow=off
bjam -j%NUMBER_OF_PROCESSORS% toolset=msvc-8.0 define=_SECURE_SCL=0 define=_CRT_SECURE_NO_DEPRECATE define=_CRT_SECURE_NO_WARNINGS --without-mpi debug release install runtime-link=shared link=shared threading=multi asynch-exceptions=on exception-handling=on extern-c-nothrow=off --prefix=..\boost
cd ..

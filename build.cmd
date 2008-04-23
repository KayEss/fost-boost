call "c:\Program Files\Microsoft Visual Studio 8\VC\bin\vcvars32.bat"
rmdir build /s /q
svn export src build
compile

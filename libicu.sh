#!/bin/sh
source ./0_append_distro_path.sh

untar_file icu4c-60_2-src.tar

cd /c/Temp/gcc
mv icu src
mkdir build dest
cd build

LIBS="-lmsvcr100" CFLAGS="-s -DMINGW_HAS_SECURE_API" CXXFLAGS="-s -DMINGW_HAS_SECURE_API" ../src/source/RunConfigureICU MinGW --prefix=/c/Temp/gcc/dest --disable-renaming --disable-rpath --enable-release --disable-debug --disable-shared --enable-static --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32
make $X_MAKE_JOBS all
make install
cd /c/Temp/gcc
rm -rf build src
mv dest icu4c-60_2
cd icu4c-60_2
rm -rf bin lib/pkgconfig lib/*.la share

7z -mx0 a ../icu4c-60_2.7z *

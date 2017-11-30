#!/bin/sh

source ./0_append_distro_path.sh

untar_file libiconv-1.15.tar
untar_file gettext-0.19.8.1.tar

cd /c/temp/gcc

mv libiconv-1.15 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared "CFLAGS=-s -O3" 

make $X_MAKE_JOBS all 
make install

cd /c/temp/gcc
mv src libiconv-1.15
rm -rf build 

mv gettext-0.19.8.1 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared --enable-static "CFLAGS=-s -O3" "CPPFLAGS=-DLIBXML_STATIC"

make $X_MAKE_JOBS all
make install
cd /c/temp/gcc
rm -rf build src

mv libiconv-1.15 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared "CFLAGS=-s -O3"

make $X_MAKE_JOBS all
make install
cd /c/temp/gcc
rm -rf build src

mv dest gettext+libiconv
cd gettext+libiconv
rm -rf lib/cmake lib/pkgconfig lib/*.la share

7z -mx0 a ../gettext+libiconv.7z *
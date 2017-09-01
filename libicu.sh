#!/bin/sh

source ./0_append_distro_path.sh

extract_file icu4c-57_1-src.tar

cd /c/data/Temp/gcc
mv icu src
mkdir build dest
cd build

CFLAGS="-s -O3" ../src/source/RunConfigureICU MinGW --prefix=/c/data/Temp/gcc/dest --disable-renaming --disable-rpath --enable-static --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --disable-shared || fail_with freetype 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with freetype 2 - EPIC FAIL
make install || fail_with freetype 3 - EPIC FAIL
cd /c/data/Temp/gcc
rm -rf build src
mv dest icu4c-57_1
cd icu4c-57_1
rm -rf bin lib/pkgconfig lib/*.la share

7z -mx0 a ../icu4c-57_1.7z *

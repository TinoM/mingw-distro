#!/bin/sh

source ./0_append_distro_path.sh

extract_file libiconv-1.15.tar
extract_file gettext-0.19.8.tar
# extract_file libxml2-2.9.4.tar

cd /c/data/temp/gcc

# mv libxml2-2.9.4 src
# mkdir build
# cd build

# ../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
# --prefix=/c/data/temp/gcc/dest --disable-shared "CFLAGS=-s -O3" || fail_with LIBXML2 1 - EPIC FAIL

# make $X_MAKE_JOBS all || fail_with LIBXML2 2 - EPIC FAIL
# make install || fail_with LIBXML2 3 - EPIC FAIL
# cd /c/data/temp/gcc
# rm -rf build src

mv libiconv-1.15 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/data/temp/gcc/dest --disable-shared "CFLAGS=-s -O3" || fail_with LIBICONV 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with LIBICONV 2 - EPIC FAIL
make install || fail_with LIBICONV 3 - EPIC FAIL

cd /c/data/temp/gcc
mv src libiconv-1.15
rm -rf build 

mv gettext-0.19.8 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/data/temp/gcc/dest --disable-shared --enable-static "CFLAGS=-s -O3" "CPPFLAGS=-DLIBXML_STATIC" || fail_with GETTEXT 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with GETTEXT 2 - EPIC FAIL
make install || fail_with GETTEXT 3 - EPIC FAIL
cd /c/data/temp/gcc
rm -rf build src

mv libiconv-1.15 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/data/temp/gcc/dest --disable-shared "CFLAGS=-s -O3" || fail_with LIBICONV 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with LIBICONV 2 - EPIC FAIL
make install || fail_with LIBICONV 3 - EPIC FAIL
cd /c/data/temp/gcc
rm -rf build src

mv dest gettext+libiconv
cd gettext+libiconv
rm -rf lib/cmake lib/pkgconfig lib/*.la share

7z -mx0 a ../gettext+libiconv.7z *
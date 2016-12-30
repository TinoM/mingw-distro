#!/bin/sh

source ./0_append_distro_path.sh

extract_file gettext-0.19.8.tar

patch -d /c/temp/gcc/gzip-1.8 -p1 < gzip-1.6-msys2.patch

cd /c/temp/gcc

mv gzip-1.8 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/bin/mingw || fail_with GZIP 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-s -O3" || fail_with GZIP 2 - EPIC FAIL
make install || fail_with GZIP 3 - EPIC FAIL
cd /c/temp/gcc
rm -rf build src
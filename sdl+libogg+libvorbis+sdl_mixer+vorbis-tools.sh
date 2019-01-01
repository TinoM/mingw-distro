#!/bin/sh

source ./0_append_distro_path.sh

untar_file SDL2-2.0.9.tar
untar_file libogg-1.3.3.tar
untar_file libvorbis-1.3.6.tar
untar_file SDL2_mixer-2.0.4.tar --exclude=SDL2_mixer-2.0.4/Xcode
untar_file vorbis-tools-1.4.0.tar
untar_file SDL2_image-2.0.3.tar --exclude=SDL2_image-2.0.3/Xcode
untar_file SDL2_ttf-2.0.14.tar --exclude=SDL2_ttf-2.0.14/Xcode

patch -d /c/temp/gcc/SDL2-2.0.8 -p1 < sdl-clipcursor.patch

cd /c/temp/gcc

mv SDL2-2.0.9 src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared

make $X_MAKE_JOBS all "CFLAGS=-s -O3"
make $X_MAKE_JOBS install
cd /c/temp/gcc
rm -rf build src

mv libogg-1.3.3 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared

make $X_MAKE_JOBS all "CFLAGS=-s -O3"
make $X_MAKE_JOBS install
cd /c/temp/gcc
rm -rf build src

mv libvorbis-1.3.6 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared

make $X_MAKE_JOBS all "CFLAGS=-s -O3"
make $X_MAKE_JOBS install
cd /c/temp/gcc
rm -rf build src

mv SDL2_mixer-2.0.4 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-shared

make $X_MAKE_JOBS all "CFLAGS=-s -O3"
make $X_MAKE_JOBS install
cd /c/temp/gcc
rm -rf build src

mv SDL2_image-2.0.3 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/Temp/gcc/dest --disable-shared "CFLAGS=-s -O3"

make $X_MAKE_JOBS all || fail_with SDL_image 2 - EPIC FAIL
make install || fail_with SDL_image 3 - EPIC FAIL
cd /c/Temp/gcc
rm -rf build src

mv SDL2_ttf-2.0.14 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/Temp/gcc/dest --disable-shared "CFLAGS=-s -O3"

make $X_MAKE_JOBS all
make install
cd /c/Temp/gcc
rm -rf build src

mv vorbis-tools-1.4.0 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/temp/gcc/dest --disable-nls

make $X_MAKE_JOBS all "CFLAGS=-s -O3"
make $X_MAKE_JOBS install
cd /c/Temp/gcc
rm -rf build src

mv dest SDL+libogg+libvorbis+SDL_mixer+vorbis-tools
cd SDL+libogg+libvorbis+SDL_mixer+vorbis-tools
rm -rf bin/sdl2-config bin/freetype-config lib/cmake lib/pkgconfig lib/*.la share
for i in bin/*.exe; do mv $i ${i/x86_64-w64-mingw32-}; done

7z -mx0 a ../SDL+libogg+libvorbis+SDL_mixer+vorbis-tools.7z *

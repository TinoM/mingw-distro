#!/bin/sh

source ./0_append_distro_path.sh

untar_file glbinding-2.1.3.tar

patch -d /c/temp/gcc/glbinding-2.1.3 -p1 < glbinding.patch

cd /c/temp/gcc
mv glbinding-2.1.3 src
mkdir build dest
cd build

cmake \
"-DBUILD_SHARED_LIBS=OFF" \
"-DCMAKE_CXX_FLAGS=-DGLBINDING_USE_BOOST_THREAD -DBOOST_THREAD_VERSION=4 -s -O3 -DSYSTEM_WINDOWS" \
"-DCMAKE_INSTALL_PREFIX=/c/temp/gcc/dest" \
"-DOPENGL_gl_LIBRARY=/c/bin/mingw/x86_64-w64-mingw32/lib/libopengl32.a" \
"-DOPENGL_INCLUDE_DIR=/c/bin/mingw/x86_64-w64-mingw32/include/gl" \
"-DOPTION_BUILD_TESTS=OFF" \
"-DOPTION_BUILD_TOOLS=OFF" \
-G "Unix Makefiles" /c/temp/gcc/src

make $X_MAKE_JOBS
make install
cd /c/temp/gcc
rm -rf build src
mv dest glbinding-2.1.3
cd glbinding-2.1.3
rm -rf AUTHORS README.md VERSION
mv LICENSE include/glbinding

7z -mx0 a ../glbinding-2.1.3.7z *

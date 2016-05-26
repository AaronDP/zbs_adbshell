#!/bin/sh
# build wxWidgets
export DEV_PREFIX=/opt
export ANDROID_NDK=${DEV_PREFIX}/ndk
export CROSS_COMPILE=arm-linux-androideabi
export ANDROID_PREFIX=/tmp/chain
export SYSROOT=${ANDROID_NDK}/platforms/android-17/arch-arm
export CROSS_PATH=${ANDROID_PREFIX}/bin/${CROSS_COMPILE}
export CPP=${CROSS_PATH}-cpp
export AR=${CROSS_PATH}-ar
export AS=${CROSS_PATH}-as
export NM=${CROSS_PATH}-nm
export CC=${CROSS_PATH}-gcc
export CXX=${CROSS_PATH}-g++
export LD=${CROSS_PATH}-ld
export RANLIB=${CROSS_PATH}-ranlib
export PREFIX=${DEV_PREFIX}/output
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
export CFLAGS="-Os -fPIC -UHAVE_LOCALE_H --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${ANDROID_PREFIX}/include -I${DEV_PREFIX}/android/bionic -I/data/local/tmp/lib/include"
export CPPFLAGS="${CFLAGS}"
export LDFLAGS="${LDFLAGS} -L${SYSROOT}/usr/lib -L${ANDROID_PREFIX}/lib -L/data/local/tmp/lib"
# ./configure --host=${CROSS_COMPILE} --with-sysroot=${SYSROOT} --prefix=${PREFIX} "$@"
#./configure --host=arm-unknown-none --with-sysroot=${SYSROOT} --prefix=${PREFIX} "$@"
#./configure --prefix=${PREFIX} "$@"
#./configure --host=${CROSS_COMPILE} --prefix=${PREFIX} "$@"
cd wxWidgets
./configure \
  $WXWIDGETSDEBUG \
  --host=${CROSS_COMPILE} \
  --with-sysroot=${SYSROOT} \
  --prefix=${PREFIX} \
  --disable-shared \
  --enable-unicode \
  --enable-compat28 \
  --with-libjpeg=builtin \
  --with-libpng=builtin \
  --with-libtiff=no \
  --with-expat=no \
  --with-zlib=builtin \
  --disable-richtext \
  --with-gtk=2 \
  "CFLAGS=${CFLAGS}" "CXXFLAGS=${CPPFLAGS}" "LDFLAGS=${LDFLAGS}""$@"
#make $MAKEFLAGS || { echo "Error: failed to build wxWidgets"; exit 1; }
#make install
#rm -rf "$WXWIDGETS_BASENAME"

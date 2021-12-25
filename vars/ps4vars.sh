#!/usr/bin/env bash

export PACBREW=/opt/pacbrew
export OPENORBIS=${PACBREW}/ps4/openorbis
export OO_PS4_TOOLCHAIN=${PACBREW}/ps4/openorbis
export PS4SDK=${PACBREW}/ps4/openorbis

export CC=${OPENORBIS}/bin/clang
export CXX=${OPENORBIS}/bin/clang++
export AS=${OPENORBIS}/bin/clang
export LD=${OPENORBIS}/bin/ld.lld
export AR=${OPENORBIS}/bin/llvm-ar
export RANLIB=${OPENORBIS}/bin/llvm-ranlib
export NM=${OPENORBIS}/bin/llvm-nm
export OBJCOPY=${OPENORBIS}/bin/llvm-objcopy
export STRIP=${OPENORBIS}/bin/llvm-strip

export PKG_CONFIG=${OPENORBIS}/usr/bin/openorbis-pkg-config
export PKG_CONFIG_PATH=${OPENORBIS}/usr/lib/pkgconfig
export PATH=${OPENORBIS}/bin:${OPENORBIS}/usr/bin:$PATH

export ARCH="--target=x86_64-pc-freebsd12-elf"
export CFLAGS="${ARCH} -D__PS4__ -D__OPENORBIS__ -D__ORBIS__ -O2 -fPIC -funwind-tables -isysroot ${OPENORBIS} -isystem ${OPENORBIS}/include -I${OPENORBIS}/usr/include"
export CXXFLAGS="${CFLAGS} -isystem ${OPENORBIS}/include/c++/v1"
export CPPFLAGS="${CFLAGS} -isystem ${OPENORBIS}/include/c++/v1"

export LIBS="-L${OPENORBIS}/lib -L${OPENORBIS}/usr/lib -nostdlib -lc -lkernel"
export LDFLAGS="${ARCH} -fuse-ld=lld -Wl,-melf_x86_64 -Wl,-pie -Wl,--script=${OPENORBIS}/link.x -Wl,--eh-frame-hdr ${LIBS}"
#${OPENORBIS}/lib/crt1.o

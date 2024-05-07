# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-clang
pkgver=12.0.1
pkgrel=1
pkgdesc='clang for ps4'
arch=('any')
url='https://github.com/llvm/llvm-project/'
license=('custom:Apache 2.0 with LLVM Exception')
options=(!debug !strip libtool)
source=(
  "https://github.com/llvm/llvm-project/releases/download/llvmorg-$pkgver/llvm-project-$pkgver.src.tar.xz"
  "001-ps4.patch"
)
sha256sums=(
  '129cb25cd13677aad951ce5c2deb0fe4afc1e9d98950f53b51bdcfb5a73afa0e'
  '811cad73d4b1dd7d0989be8b60b84c64317712ace4d8e51a01b673322f48fd83'
)
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

prepare() {
  cd llvm-project-$pkgver.src
  patch -Np1 -i "../001-ps4.patch"
}

build() {
  cd llvm-project-$pkgver.src
  
  cmake \
    -G "Unix Makefiles" \
    -S llvm -B build \
    -DLLVM_INCLUDE_TESTS=Off \
    -DLLVM_INCLUDE_EXAMPLES=Off \
    -DLLVM_INCLUDE_BENCHMARKS=Off \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_ENABLE_PROJECTS="lld;clang" \
    -DLLVM_ENABLE_LIBCXX=On \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DLLVM_INSTALL_BINUTILS_SYMLINKS=On \
    -DLLVM_INSTALL_CCTOOLS_SYMLINKS=On \
    -DLLVM_STATIC_LINK_CXX_STDLIB=On \
    -DCMAKE_INSTALL_PREFIX=/opt/pacbrew/ps4/openorbis \
    ..

  cd build && make
}

package() {
  cd llvm-project-$pkgver.src/build
  make DESTDIR="${pkgdir}" install
}

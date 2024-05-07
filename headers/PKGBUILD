# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-headers
pkgver=0.5.2
pkgrel=4
pkgdesc='headers for ps4 (include crtlib...)'
gitrev='cd480230b946239f758333ef0dff40d67c5f0c20'
arch=('any')
url='https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain'
license=('GNU GPL')
options=(!debug !strip libtool)
source=("https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/archive/$gitrev.zip")
sha256sums=('b77f9ba633cfe1cc829220321ea808b8990f4a625ccbad75b4f8f7686a9d8161')
depends=('ps4-openorbis-clang')
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

build() {
  cd OpenOrbis-PS4-Toolchain-$gitrev/src/crt
  /opt/pacbrew/ps4/openorbis/bin/clang -c -o crtlib.o crtlib.c
}

package() {
  install -d "${pkgdir}"/opt/pacbrew/ps4/openorbis/lib
  install -m755 OpenOrbis-PS4-Toolchain-$gitrev/src/crt/crtlib.o ${pkgdir}/opt/pacbrew/ps4/openorbis/lib
  install -m755 OpenOrbis-PS4-Toolchain-$gitrev/link.x ${pkgdir}/opt/pacbrew/ps4/openorbis
  cp -r OpenOrbis-PS4-Toolchain-$gitrev/include ${pkgdir}/opt/pacbrew/ps4/openorbis
  cp -r OpenOrbis-PS4-Toolchain-$gitrev/samples ${pkgdir}/opt/pacbrew/ps4/openorbis
}

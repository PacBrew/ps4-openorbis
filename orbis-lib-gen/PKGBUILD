# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-orbis-lib-gen
pkgver=1.3
pkgrel=2
pkgdesc='libs for ps4'
arch=('any')
url='https://github.com/OpenOrbis/orbis-lib-gen'
license=('GNU GPL')
options=(!debug !strip libtool)
source=(
  "https://github.com/OpenOrbis/orbis-lib-gen/releases/download/v$pkgver/lib.tar.gz"
  "libSceLibcInternal.so"
)
sha256sums=(
  '050b4898510dc6836c0d14a54d740c81be9ce376b1f2f8a5e57699eb82d584cf'
  'b13d45fb931c6eb3515bf5c3eafd8d0ca028b9af0dd32807760d6ce1c0cce617'
)
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

package() {
  mkdir -p "$pkgdir"/opt/pacbrew/ps4/openorbis/lib
  cp lib/* "$pkgdir"/opt/pacbrew/ps4/openorbis/lib

  # we need a stripped version of "libSceLibcInternal.so" (without malloc and such)
  # so malloc (and such) are always called from musl wrapper (for mini apps)
  cp ${srcdir}/libSceLibcInternal.so ${pkgdir}/opt/pacbrew/ps4/openorbis/lib
}

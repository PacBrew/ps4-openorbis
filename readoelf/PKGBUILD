# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-readoelf
pkgver=1.0
pkgrel=2
pkgdesc='readoelf for ps4'
arch=('any')
url='https://github.com/OpenOrbis/readoelf'
license=('MIT')
options=(!debug !strip libtool)
source=(
  "https://github.com/OpenOrbis/readoelf/archive/refs/tags/v$pkgver.tar.gz"
  "https://go.dev/dl/go1.17.5.linux-amd64.tar.gz"
)
sha256sums=(
  '96e700ae4b4b0d908da4c96a8aba7e249428aaf5fe1a0d2f88ba73b77d28b8e4'
  'bd78114b0d441b029c8fe0341f4910370925a4d270a6a590668840675b0c653e'
)
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

build() {
  cd readoelf-$pkgver

  cd cmd/readoelf
  ../../../go/bin/go build -o readoelf
}

package() {
  cd readoelf-$pkgver
  install -d $pkgdir/opt/pacbrew/ps4/openorbis/bin
  install -m755 cmd/readoelf/readoelf $pkgdir/opt/pacbrew/ps4/openorbis/bin/readoelf
}

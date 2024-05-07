# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-create-fself
pkgver=1.2
pkgrel=3
pkgdesc='create-fself for ps4'
arch=('any')
url='https://github.com/OpenOrbis/create-fself'
license=('MIT')
options=(!debug !strip libtool)
source=(
  "https://github.com/OpenOrbis/create-fself/archive/30d2e10507f55124cf21e85e19825482e4f93c87.zip"
  "https://go.dev/dl/go1.17.5.linux-amd64.tar.gz"
)
sha256sums=(
  'f232b59abb74324125665041e7ed152f4556dd7b37b284b62c260b2d5f6cf868'
  'bd78114b0d441b029c8fe0341f4910370925a4d270a6a590668840675b0c653e'
)
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

build() {
  cd create-fself-30d2e10507f55124cf21e85e19825482e4f93c87

  cd cmd/create-fself
  ../../../go/bin/go build -o create-fself -modfile=go-linux.mod
}

package() {
  cd create-fself-30d2e10507f55124cf21e85e19825482e4f93c87
  install -d $pkgdir/opt/pacbrew/ps4/openorbis/bin/linux
  install -m755 cmd/create-fself/create-fself $pkgdir/opt/pacbrew/ps4/openorbis/bin/create-fself
  cd $pkgdir/opt/pacbrew/ps4/openorbis/bin/linux && ln -s ../create-fself create-fself
}

# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-vars
pkgver=1.1
pkgrel=3
pkgdesc='helper scripts to set variables for ps4 toolchain'
arch=('any')
url='https://github.com/PacBrew'
source=('ps4vars.sh' 'ps4.cmake' 'openorbis-cmake')
options=(!debug !strip)
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

sha256sums=(
  '6557113238446b3f2d05ff2e4b6cc790cfdece0d0682b42b8334663c5b1be3bb' # ps4vars.sh
  '2b74e57e47fcb4aaead0006d0c1a91f1222002cd572b0e6b0e4ca6d9e0e86dc4' # ps4.cmake
  '0a32ce4e9a41e91df50e036f9f22b2aafac2778ae8286b8b7fc84fafb38aa38a' # openorbis-cmake
)

package() {
  install -d "$pkgdir"/opt/pacbrew/ps4/openorbis
  install -Dm644 ps4vars.sh "$pkgdir"/opt/pacbrew/ps4/openorbis
  
  install -d "$pkgdir"/opt/pacbrew/ps4/openorbis/cmake
  install -Dm644 ps4.cmake "$pkgdir"/opt/pacbrew/ps4/openorbis/cmake
  install -d "$pkgdir"/opt/pacbrew/ps4/openorbis/usr/bin
  install -Dm755 openorbis-cmake "$pkgdir"/opt/pacbrew/ps4/openorbis/usr/bin
}

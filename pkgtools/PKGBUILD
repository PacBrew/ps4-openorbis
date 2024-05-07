# Maintainer: cpasjuste <cpasjuste@gmail.com>

pkgname=ps4-openorbis-pkgtools
pkgver=0.2.231
pkgrel=5
pkgdesc='pkg tools for ps4'
arch=('any')
url='https://github.com/OpenOrbis/LibOrbisPkg'
license=('GNU GPL')
options=(!debug !strip libtool)
commit=('594021fdc435409f755a6ae0781b65ec6cec846c')
source=("https://github.com/OpenOrbis/LibOrbisPkg/archive/${commit}.zip" "PkgTool.Core")
sha256sums=(
  'd6084ef02a5841db2866c04c6d010477fd04a31c795c8070b535ad2a7c8ef565'
  'ec2acf02469f8a3b209b1ab42cb3d9f5104159a52bf07bbe0969c076124e7d5e' # bash script wrapper for PkgTool.Core
)
groups=(
  'pacbrew' 'pacbrew-ps4' 'pacbrew-ps4-toolchain' 
  'ps4-openorbis' # for backward compatibility
)

build() {
  cd LibOrbisPkg-${commit}
  dotnet publish -r linux-x64 -c Release LibOrbisPkg.Core.sln
}

package() {
  # install PkgTool.Core wrapper script
  install -d ${pkgdir}/opt/pacbrew/ps4/openorbis/bin/linux/pkgtool
  install -Dm755 PkgTool.Core ${pkgdir}/opt/pacbrew/ps4/openorbis/bin/linux

  # install PkgTool.Core
  cd LibOrbisPkg-${commit}
  cp -R PkgTool.Core/bin/Release/net6.0/linux-x64/publish/. ${pkgdir}/opt/pacbrew/ps4/openorbis/bin/linux/pkgtool
}

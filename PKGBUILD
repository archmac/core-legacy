
pkgname=pacman
pkgver=3.5.3
pkgrel=9
pkgdesc="A library-based package manager with dependency support"
arch=('i386')
url="http://www.archlinux.org/pacman/"
license=('GPL')
groups=('base')
depends=('bash' 'libarchive>=2.8.4')
optdepends=('fakeroot: for makepkg usage as normal user'
            'curl: for rankmirrors usage')
backup=(Library/Arch/etc/pacman.conf Library/Arch/etc/makepkg.conf)
options=(!libtool)
source=(ftp://ftp.archlinux.org/other/pacman/${pkgname}-${pkgver}.tar.gz
        pacman.conf
        makepkg.conf
        fix_libaplm_libs.patch)
md5sums=('c36c18ed4d8ec69c0ecb4f9684266901'
         'a128522abb7e442cc640a09025735eb8'
         '29fe9ac875463dd23fbe44da86cfcc78'
         '29b24726b032c8867550b4e7fbb401e8')

# keep an upgrade path for older installations
PKGEXT='.pkg.tar.gz'

build() {
  cd $srcdir/$pkgname-$pkgver

  # to work with Macintosh's 'strip'
  sed -i '' -e 's/--strip-debug/-S/' scripts/makepkg.sh.in
  ./configure --prefix=/Library/Arch --enable-doc

  # to add required libraries
  patch -p0 < $startdir/fix_libaplm_libs.patch
  make
}

package() {
  cd $srcdir/$pkgname-$pkgver
  CFLAGS="-I/Library/Arch/include" make DESTDIR=$pkgdir install

  # install ArchMac-specific setup
  install -m644 $srcdir/pacman.conf \
    $pkgdir/Library/Arch/etc/pacman.conf
  install -m644 $srcdir/makepkg.conf \
    $pkgdir/Library/Arch/etc/makepkg.conf

  # install shell auto-completion
  mkdir -p $pkgdir/Library/Arch/etc/bash_completion.d
  install -m644 contrib/bash_completion \
    $pkgdir/Library/Arch/etc/bash_completion.d/pacman
  mkdir -p $pkgdir/Library/Arch/share/zsh/site-functions
  install -m644 contrib/zsh_completion \
    $pkgdir/Library/Arch/share/zsh/site-functions/_pacman
}


pkgname=fakeroot
pkgver=1.16
pkgrel=7
pkgdesc="Gives a fake root environment, useful for building packages as a non-privileged user"
arch=('i386')
license=('GPL')
url="http://packages.debian.org/fakeroot"
groups=('base-devel')
depends=('filesystem' 'sed' 'sh')
options=('!libtool')
source=(http://ftp.debian.org/pool/main/f/${pkgname}/${pkgname}_${pkgver}.orig.tar.bz2)
md5sums=('e8470aa7e965bfc74467de0e594e60b6')

build() {
  cd $srcdir/$pkgname-$pkgver
  ./configure --prefix=/Library/ArchMac \
    --disable-static --with-ipc=sysv
  make wrapped.h
  make libmacosx.la
  make
}

package() {
  cd $srcdir/$pkgname-$pkgver
  make DESTDIR=$pkgdir install

  # install README for sysv/tcp usage
  mkdir -p $pkgdir/Library/ArchMac/share/doc/$pkgname
  install -m644 $srcdir/$pkgname-$pkgver/README \
    $pkgdir/Library/ArchMac/share/doc/$pkgname/README
}


pkgname=fakeroot
pkgver=1.14.4
pkgrel=11
pkgdesc="Gives a fake root environment, useful for building packages as a non-privileged user"
arch=(i386 x86_64)
license=(GPL)
url="http://packages.debian.org/fakeroot"
groups=(core)
source=(http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_${pkgver}.orig.tar.bz2)
md5sums=(bea628be77838aaa7323a2f7601c2d7e)

build() {
    cd $srcdir/$pkgname-$pkgver
    ./configure --prefix=/Library/ArchMac \
                --docdir=/Library/ArchMac/doc \
                --mandir=/Library/ArchMac/man \
                --disable-static --with-ipc=sysv
    make wrapped.h libmacosx.la all
}

package() {
    cd $srcdir/$pkgname-$pkgver
    make DESTDIR=$pkgdir install

    # install README for sysv/tcp usage
    mkdir -p $pkgdir/Library/ArchMac/doc/$pkgname
    install -m644 $srcdir/$pkgname-$pkgver/README \
        $pkgdir/Library/ArchMac/doc/$pkgname/README
}

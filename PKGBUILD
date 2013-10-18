
pkgname=pacman
pkgver=4.0.3
pkgrel=10
pkgdesc="A library-based package manager with dependency support"
arch=(i386 x86_64)
url="http://www.archlinux.org/pacman/"
license=(GPL)
groups=(core)
backup=(Library/ArchMac/etc/pacman.conf
        Library/ArchMac/etc/makepkg.conf)
source=(ftp://ftp.archlinux.org/other/pacman/pacman-${pkgver}.tar.gz
        makepkg.conf)
md5sums=(387965c7125e60e5f0b9ff3b427fe0f9
         51688ce9efdef3ce84370608d60d5602)


build() {
    cd $srcdir/$pkgname-$pkgver

    export LIBS="$LIBS -lcrypto"

    # to work with Macintosh's 'strip'
    sed -i '' -e 's/--strip-debug/-S/' scripts/makepkg.sh.in

    ./configure --prefix=/Library/ArchMac \
                --mandir=/Library/ArchMac/man

    make
}

package() {
    cd $srcdir/$pkgname-$pkgver
    make DESTDIR=$pkgdir install

    install -m644 $srcdir/makepkg.conf $pkgdir/Library/ArchMac/etc

    # install shell auto-completion
    mkdir -p $pkgdir/Library/ArchMac/etc/bash_completion.d
    install -m644 contrib/bash_completion \
        $pkgdir/Library/ArchMac/etc/bash_completion.d/pacman
    mkdir -p $pkgdir/Library/ArchMac/share/zsh/site-functions
    install -m644 contrib/zsh_completion \
        $pkgdir/Library/ArchMac/share/zsh/site-functions/_pacman
}


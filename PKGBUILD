
pkgname=pacman
pkgver=4.0.3
pkgrel=3
pkgdesc="A library-based package manager with dependency support"
arch=(i386 x86_64)
url="http://www.archlinux.org/pacman/"
license=(GPL)
groups=(core)
backup=(Library/ArchMac/etc/pacman.conf Library/ArchMac/etc/makepkg.conf)
source=(ftp://ftp.archlinux.org/other/pacman/pacman-${pkgver}.tar.gz)
md5sums=(387965c7125e60e5f0b9ff3b427fe0f9)

build() {
    cd $srcdir/$pkgname-$pkgver

    export LIBS="$LIBS -lcrypto"

    # to work with Macintosh's 'strip'
    sed -i '' -e 's/--strip-debug/-S/' scripts/makepkg.sh.in

    ./configure --prefix=/Library/ArchMac --enable-doc

    make
}

package() {
    cd $srcdir/$pkgname-$pkgver
    make DESTDIR=$pkgdir install

    # install shell auto-completion
    mkdir -p $pkgdir/Library/ArchMac/etc/bash_completion.d
    install -m644 contrib/bash_completion \
        $pkgdir/Library/ArchMac/etc/bash_completion.d/pacman
    mkdir -p $pkgdir/Library/ArchMac/share/zsh/site-functions
    install -m644 contrib/zsh_completion \
        $pkgdir/Library/ArchMac/share/zsh/site-functions/_pacman
}


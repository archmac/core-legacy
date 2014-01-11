# maintainer Andrew Schleifer <me@andrewschleifer.name>

pkgname=archmac
pkgver=2
pkgrel=22
pkgdesc='Base filesystem'
arch=(any)
license=(GPL)
url='http://www.archmac.org'
groups=(core)
source=(profile)
replaces=(filesystem)
conflicts=(filesystem)
md5sums=(df650a4de6503a72f48c9ad7cf3d2337)

package() {
    cd $srcdir

    for dir in bin etc frameworks include info lib man share var; do
        install -d -m755 $pkgdir/Library/ArchMac/$dir
    done

    install -m644 $srcdir/profile \
        $pkgdir/Library/ArchMac/etc/profile
}



pkgname=archmac
pkgver=2
pkgrel=20
pkgdesc='Base filesystem'
arch=(any)
license=(GPL)
url='http://www.archmac.org'
groups=(base)
source=(profile)
replaces=(filesystem)
conflicts=(filesystem)
md5sums=(4ebe9dba884c9f8c0ae74a475c5d8712)

package() {
    cd $srcdir

    for dir in bin etc frameworks include info lib man share var; do
        install -d -m755 $pkgdir/Library/ArchMac/$dir
    done

    install -m644 $srcdir/profile \
        $pkgdir/Library/ArchMac/etc/profile
}


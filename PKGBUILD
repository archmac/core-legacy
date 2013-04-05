
pkgname=(osx-system)
pkgver=10.8
pkgrel=4
pkgdesc='Software provided by OS X'
arch=(any)
url='http://www.apple.com/macosx'
license=(various)
group=(core)
provides=(bash bzip2 curl expat libarchive libedit openssl perl python ruby sed zlib)
source=(archive.h
        archive_entry.h)
md5sums=(f63f14fddd171901e7d2123e8af40945
         48f9e8e2683f890941ee05990e1d014d)

package() {

    install -m755 -d $pkgdir/Library/ArchMac/include
    install -m644 archive.h $pkgdir/Library/ArchMac/include
    install -m644 archive_entry.h $pkgdir/Library/ArchMac/include
}


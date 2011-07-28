
pkgname=filesystem
pkgver=0.2
pkgrel=4
pkgdesc='Base filesystem'
arch=('any')
license=('GPL')
url='http://www.archmac.org'
groups=('base')
source=(env.sh)
md5sums=('4aaa9ca6b1d0d88e704dd46c1fcea6f8')

package() {
	cd $srcdir

	for dir in bin etc include lib share var; do
		install -d -m755 $pkgdir/Library/ArchMac/$dir
	done

	mkdir -p $pkgdir/Library/ArchMac/etc/archmac
	install -m644 $srcdir/env.sh \
        $pkgdir/Library/ArchMac/etc/archmac/
}

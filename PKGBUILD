
pkgname=filesystem
pkgver=0.1
pkgrel=5
pkgdesc='Base filesystem'
arch=('any')
license=('GPL')
url='http://www.archmac.org'
groups=('base')
source=(env.sh)
md5sums=('5c8b4d41b893b918ca148c87a62c6bb0')

package() {
	cd $srcdir

	for dir in bin etc include lib share var; do
		install -d -m755 $pkgdir/Library/Arch/$dir
	done

	mkdir -p $pkgdir/Library/Arch/etc/archmac
	install -m644 $srcdir/env.sh \
	  $pkgdir/Library/Arch/etc/archmac/
}

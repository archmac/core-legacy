WORK:=$(shell mktemp -d /tmp/archmac.XXXXX)

bootstrap:
	mkdir $(WORK)/src
	curl -L http://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz | tar -C $(WORK)/src -x
	curl -L http://ftpmirror.gnu.org/automake/automake-1.12.tar.gz | tar -C $(WORK)/src -x
	curl -L http://ftpmirror.gnu.org/libtool/libtool-2.4.tar.gz | tar -C $(WORK)/src -x
	curl -L https://github.com/downloads/libarchive/libarchive/libarchive-2.8.3.tar.gz | tar -C $(WORK)/src -x
	curl -L http://ftp.us.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.14.4.orig.tar.bz2 | tar -C $(WORK)/src -x
	curl -L ftp://ftp.archlinux.org/other/pacman/pacman-4.0.3.tar.gz | tar -C $(WORK)/src -x
	cd $(WORK)/src/autoconf-*   && PATH=$(WORK)/bin:$$PATH ./configure --prefix=$(WORK) 
	cd $(WORK)/src/autoconf-*   && PATH=$(WORK)/bin:$$PATH make install
	cd $(WORK)/src/automake-*   && PATH=$(WORK)/bin:$$PATH ./configure --prefix=$(WORK)
	cd $(WORK)/src/automake-*   && PATH=$(WORK)/bin:$$PATH make install
	cd $(WORK)/src/libtool-*    && PATH=$(WORK)/bin:$$PATH ./configure --prefix=$(WORK)
	cd $(WORK)/src/libtool-*    && PATH=$(WORK)/bin:$$PATH make install
	cd $(WORK)/src/libarchive-* && PATH=$(WORK)/bin:$$PATH ./configure --prefix=$(WORK)
	cd $(WORK)/src/libarchive-* && PATH=$(WORK)/bin:$$PATH make install-includeHEADERS
	cd $(WORK)/src/fakeroot-*   && PATH=$(WORK)/bin:$$PATH ./configure --prefix=$(WORK)
	cd $(WORK)/src/fakeroot-*   && PATH=$(WORK)/bin:$$PATH make wrapped.h
	cd $(WORK)/src/fakeroot-*   && PATH=$(WORK)/bin:$$PATH make libmacosx.la
	cd $(WORK)/src/fakeroot-*   && PATH=$(WORK)/bin:$$PATH make
	cd $(WORK)/src/fakeroot-*   && PATH=$(WORK)/bin:$$PATH make install
	cd $(WORK)/src/pacman-*     && CFLAGS=-I$(WORK)/include LIBS=-lcrypto ./configure --prefix=$(WORK) --disable-doc
	cd $(WORK)/src/pacman-*     && CFLAGS=-I$(WORK)/include LIBS=-lcrypto make install
	echo CFLAGS=\"-I$(WORK)/include -L$(WORK)/lib\" >> $(WORK)/etc/makepkg.conf
	cd fakeroot   && PATH=$(WORK)/bin:$$PATH makepkg -df
	cd filesystem && PATH=$(WORK)/bin:$$PATH makepkg -df
	cd osx-system && PATH=$(WORK)/bin:$$PATH makepkg -df
	cd pacman     && PATH=$(WORK)/bin:$$PATH makepkg -df
	mv */*.pkg.tar.gz .


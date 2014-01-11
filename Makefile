ifndef WORK
	WORK:=$(shell mktemp -d /tmp/archmac.XXXXX)
endif

DATE:=$(shell date +%Y-%m-%d)
ARCHIVES=\
    http://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz \
    http://ftpmirror.gnu.org/automake/automake-1.12.tar.gz \
    http://ftpmirror.gnu.org/libtool/libtool-2.4.tar.gz \
    https://github.com/downloads/libarchive/libarchive/libarchive-2.8.3.tar.gz \
    http://ftp.us.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.18.4.orig.tar.bz2 \
    ftp://ftp.archlinux.org/other/pacman/pacman-4.0.3.tar.gz

bootstrap: download unpack prereqs core
	@echo
	@echo "ArchMac core prepared. To install run:"
	@echo "$$ sudo mkdir -p /Library/ArchMac/var/lib/pacman"
	@echo "$$ sudo $(WORK)/bin/pacman -U -r/ -b /Library/ArchMac/var/lib/pacman */*.pkg.tar.gz"
	@echo
	@echo "And then tidy up with:"
	@echo "$$ make cleanup && rm -rf $(WORK)"

download:
	@for archive in $(ARCHIVES); do echo Downloading $$archive; cd /tmp; touch $${archive##*/}; curl -s -C- -L -O $$archive < $${archive##*/}; done

unpack: $(foreach archive,$(ARCHIVES),/tmp/$(shell basename $(archive)))
	@echo Working in $(WORK)
	@mkdir -p $(WORK)/src
	@for file in $^; do echo Extracting $$file && tar -C $(WORK)/src -x -f $$file; done

prereqs:
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
	cd $(WORK)/src/pacman-*     && CFLAGS="-I$(WORK)/include -std=gnu89" LIBS=-lcrypto ./configure --prefix=$(WORK) --disable-doc
	cd $(WORK)/src/pacman-*     && CFLAGS="-I$(WORK)/include -std=gnu89" LIBS=-lcrypto make install
	echo CFLAGS=\"-I$(WORK)/include -L$(WORK)/lib\" >> $(WORK)/etc/makepkg.conf
	echo SRCDEST=/tmp >> $(WORK)/etc/makepkg.conf

core:
	cd fakeroot   && PATH=$(WORK)/bin:$$PATH makepkg -df
	cd archmac    && PATH=$(WORK)/bin:$$PATH makepkg -df
	cd osx-system && PATH=$(WORK)/bin:$$PATH makepkg -df
	cd pacman     && PATH=$(WORK)/bin:$$PATH makepkg -df

cleanup:
	@for file in $(foreach archive,$(ARCHIVES),/tmp/$(shell basename $(archive))); do rm $$file; done

release:
	cp `ls fakeroot/*.pkg.tar.gz | tail -1` $(WORK)
	cp `ls archmac/*.pkg.tar.gz | tail -1` $(WORK)
	cp `ls osx-system/*.pkg.tar.gz | tail -1` $(WORK)
	cp `ls pacman/*.pkg.tar.gz | tail -1` $(WORK)
	cd $(WORK) && mkdir -p Library/ArchMac/var/lib/pacman
	cd $(WORK) && sudo pacman -U --noconfirm -r. -b Library/ArchMac/var/lib/pacman *.pkg.tar.gz
	tar czf $(DATE).tar.gz -C $(WORK) Library
	sudo rm -rf $(WORK)

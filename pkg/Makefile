# disable content trust for now
LINUXKIT_OPTS= --disable-content-trust

BUILDARCH ?= $(shell uname -m) # The target CPU architecture == host arch if unspecified.

ifneq ($(strip ${BUILDARCH}),aarch64)
PKGS += grub dnsmasq sgdisk
endif

PKGS += xen kmod_pfring xen-tools dom0-ztools	\
	test-cert test-microsvcs qrexec-lib qrexec-dom0 wwan wlan

ifneq ($(strip ${BUILDARCH}),aarch64)
PKGS += mkrootfs-ext4 mkflash
endif

.PHONY: push force-push build forcebuild show-tag clean dockerfiles

build: dockerfiles
	@set -e; cd kernel; ${MAKE} build
	@set -e; for d in $(PKGS); do linuxkit pkg build ${LINUXKIT_OPTS} "$$d"; done

push:
	@set -e; cd kernel; ${MAKE} push
	@set -e; for d in $(PKGS); do linuxkit pkg push ${LINUXKIT_OPTS} "$$d"; done

forcepush:
	@set -e; cd kernel; ${MAKE} forcepush
	@set -e; for d in $(PKGS); do linuxkit pkg push --force ${LINUXKIT_OPTS} "$$d"; done

forcebuild:
	@set -e; cd kernel; ${MAKE} forcebuild
	@set -e; for d in $(PKGS); do linuxkit pkg build --force ${LINUXKIT_OPTS} "$$d"; done

show-tag:
	@set -e; cd kernel; ${MAKE} show-tag
	@set -e; for d in $(PKGS); do linuxkit pkg show-tag "$$d"; done

clean:
	@set -e; cd kernel; ${MAKE} clean

dockerfiles: $(addsuffix /Dockerfile, $(PKGS)/)

%: %.in FORCE
	(cd ..; ./parse-pkgs.sh pkg/$< > pkg/$@)
FORCE:

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit mount-boot

DESCRIPTION="Stand alone memory testing software for x86 computers"
HOMEPAGE="http://www.memtest86.com/"
SRC_URI="http://www.memtest86.com/downloads/memtest86-iso.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bios +efi"

DEPEND="virtual/cdrtools"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	if use efi; then
		isoinfo -i Memtest86-${PV}.iso -x /EFI/BOOT/BOOTX64.EFI\;1 > ${PN}.efi \
		|| die
	fi
	if use bios; then
		isoinfo -i Memtest86-${PV}.iso -x /ISOLINUX/MEMTEST.\;1 > ${PN}.bios \
		|| die
	fi
}

src_install() {
	insinto /boot
	doins ${PN}.*

	exeinto /etc/grub.d/
	newexe "${FILESDIR}"/${PN}-grub.d 39_memtest86-bin
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd

DESCRIPTION="UniFi Video Server"
HOMEPAGE="https://www.ubnt.com/download/unifi-video/"
SRC_URI="https://dl.ubnt.com/firmwares/ufv/v${PV}/unifi-video.Ubuntu16.04_amd64.v${PV}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-db/mongodb
	virtual/jre"

src_install() {
	insinto /usr/$(get_libdir)
	doins -r usr/lib/*
	into /usr/sbin
	dosbin usr/sbin/${PN}

	newinitd "${FILESDIR}"/${PN}.initd
	systemd-dounit "${FILESDIR}"/${PN}.service
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="RealVNC client"
HOMEPAGE="http://www.realvnc.com/"
SRC_URI="https://www.realvnc.com/download/binary/1868/ -> ${P}"

MY_PN=${PN%-client-bin}

LICENSE="RealVNC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext"

S=${WORKDIR}

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}"/${A} ${MY_PN}
	make_desktop_entry ${MY_PN} "RealVNC Client" ${MY_PN} "Network"
	doicon -s scalable "${FILESDIR}"/${MY_PN}.svg
}

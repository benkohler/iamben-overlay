# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="RealVNC client"
HOMEPAGE="http://www.realvnc.com/"
SRC_URI="https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-${PV}-Linux-x64"

MY_PN=${PN%-bin}

LICENSE="RealVNC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="x11-libs/libX11
	x11-libs/libXext"

S=${WORKDIR}

src_install() {
	newbin "${DISTDIR}/${A}" ${MY_PN}
	make_desktop_entry ${MY_PN} "RealVNC Client" ${MY_PN} "Network"
	doicon -s scalable "${FILESDIR}"/${MY_PN}.svg
}

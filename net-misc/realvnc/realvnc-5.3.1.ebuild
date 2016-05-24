# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="RealVNC client"
HOMEPAGE="http://www.realvnc.com/"
SRC_URI="https://www.realvnc.com/download/binary/1868/ -> ${P}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext"

src_install() {
	newbin ${A} ${PN}
}
# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

MY_PN="GarminPlugin"
S="${WORKDIR}/${MY_PN}-${PV}/src"

DESCRIPTION="Linux Garmin Communicator Plugin"
HOMEPAGE="http://www.andreas-diesner.de/garminplugin/doku.php"
SRC_URI="https://github.com/adiesner/${MY_PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-misc/garmintools
	dev-libs/libgcrypt:=
	dev-libs/libgpg-error
	dev-libs/tinyxml
	net-misc/npapi-sdk
	sys-libs/zlib
	virtual/libusb:0"

RDEPEND="${DEPEND}"

src_install() {
	dodoc ../README ../HISTORY

	exeinto /usr/$(get_libdir)/nsbrowser/plugins
	doexe npGarminPlugin.so
}

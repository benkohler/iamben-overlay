# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib

MY_PN="GarminPlugin"
S="${WORKDIR}/adiesner-${MY_PN}-42e30ff/src"

DESCRIPTION="Linux Garmin Communicator Plugin"
HOMEPAGE="http://www.andreas-diesner.de/garminplugin/doku.php"
SRC_URI="https://github.com/adiesner/${MY_PN}/tarball/V${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/tinyxml
	virtual/libusb:0
	app-misc/garmintools
	net-misc/npapi-sdk"
RDEPEND="${DEPEND}"

src_install() {
	dodoc ../README ../HISTORY

	exeinto /usr/$(get_libdir)/nsbrowser/plugins
	doexe npGarminPlugin.so
}

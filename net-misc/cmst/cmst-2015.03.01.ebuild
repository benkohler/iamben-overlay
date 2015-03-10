# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Qt GUI for Connman with system tray icon"
HOMEPAGE="https://github.com/andrew-bibb/cmst"
SRC_URI="${HOMEPAGE}/archive/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${P}"

DEPEND="net-misc/connman
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	x11-libs/libxkbcommon"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i misc/desktop/cmst.desktop \
		-e 's/Version=1.1/Version=1.0/' \
		-e '/Categories/ s/$/;/'
}

src_compile() {
	eqmake5
	emake
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

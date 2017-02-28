# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qmake-utils

COMMIT="593b8942353b65a507de228cfcc1459c6ee914f4"

DESCRIPTION="Qt GUI for Connman with system tray icon"
HOMEPAGE="https://github.com/andrew-bibb/cmst"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	net-misc/connman
"
S="${WORKDIR}/${PN}-${COMMIT}"

src_configure() {
	export USE_LIBPATH="${EPREFIX}/usr/$(get_libdir)/${PN}"
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	rm -r "${D}"/usr/share/licenses || die
}

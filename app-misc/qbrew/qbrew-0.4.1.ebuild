# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit qt4-r2 eutils

DESCRIPTION="Homebrewer's recipe calculator"
HOMEPAGE="http://www.usermode.org/code.html"
SRC_URI="http://www.usermode.org/code/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

src_configure() {
	export BINDIR="/usr/bin" DATADIR="/usr/share/${PN}" DOCDIR="/usr/share/doc/${P}"
	./configure --qtdir="/usr/$(get_libdir)/qt4" || die "configure failed"
	echo "QT += xml" >> qbrew.pro
	eqmake4
}

src_prepare() {
	cp "${FILESDIR}/${PN}.svg" "${S}/pics/"
}

src_install() {
	dobin qbrew || die "bin install failed"
	insinto /usr/share/${PN}
	doins data/* pics/splash.png || die "install failed"

	doicon "pics/${PN}.png"
	insinto /usr/share/icons/hicolor/scalable/apps
	doins "${FILESDIR}/${PN}.svg"
	make_desktop_entry ${PN} "QBrew" ${PN} "Education;Calculator;Engineering"

	dohtml -r docs/* || die "documentation install failed"
	dodoc AUTHORS ChangeLog README TODO || die "documentation install failed"
}

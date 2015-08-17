# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
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
	./configure --qtdir="/usr/$(get_libdir)/qt4"
	echo "QT += xml" >> qbrew.pro
	eqmake4
}

src_prepare() {
	cp "${FILESDIR}/${PN}.svg" "${S}/pics/"
}

src_install() {
	dobin qbrew
	insinto /usr/share/${PN}
	doins data/* pics/splash.png

	doicon "pics/${PN}.png"
	insinto /usr/share/icons/hicolor/scalable/apps
	doins "${FILESDIR}/${PN}.svg"
	make_desktop_entry ${PN} "QBrew" ${PN} "Education;Calculator;Engineering"

	dohtml -r docs/*
	dodoc AUTHORS ChangeLog README TODO
}

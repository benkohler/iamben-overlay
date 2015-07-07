# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit qmake-utils vcs-snapshot

DESCRIPTION="Qt connman library"
HOMEPAGE="https://bitbucket.org/devonit/qconnman/"
SRC_URI="https://bitbucket.org/devonit/${PN}/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}
	net-misc/connman"

src_compile() {
	eqmake4 PREFIX="${ED}/usr"
	emake
}

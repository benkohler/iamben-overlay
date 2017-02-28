# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit qmake-utils vcs-snapshot

COMMIT="b54504dfd26d8e8cf100d1d4ea527a1e01190531"

DESCRIPTION="A QT4 ConnMan management interface that is used on O.S. Systems products"
HOMEPAGE="https://github.com/OSSystems/qconnman-ui"
SRC_URI="https://github.com/OSSystems/qconnman-ui/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	net-libs/qconnman"
RDEPEND="${DEPEND}
	net-misc/connman"

src_configure() {
	eqmake4 PREFIX="${ED}/usr"
}

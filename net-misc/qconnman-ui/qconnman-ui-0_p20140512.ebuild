# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit qmake-utils vcs-snapshot

COMMIT="b54504dfd26d8e8cf100d1d4ea527a1e01190531"

DESCRIPTION="A ConnMan management interface that is used on O.S. Systems products"
HOMEPAGE="https://github.com/OSSystems/qconnman-ui"
SRC_URI="https://github.com/OSSystems/qconnman-ui/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/qconnman"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 PREFIX=${ED}/usr
}

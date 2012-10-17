# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="Command-line utility intended to provide quick access to current weather conditions and forecasts."
HOMEPAGE="http://fungi.yuggoth.org/${PN}"
SRC_URI="${HOMEPAGE}/src/${P}.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare () {
	sed -i -e 's/^#setpath/setpath/' ${PN}rc
}

src_install() {
	doman ${PN}.1 ${PN}rc.5
	dodoc FAQ NEWS README
	dobin ${PN}

	insinto /etc
	doins ${PN}rc

	insinto /usr/share/${PN}-util
	gzip airports places stations zctas zones
	doins airports.gz places.gz stations.gz zctas.gz zones.gz

	installation() {
		insinto $(python_get_sitedir)
		doins ${PN}.py
	}
	python_execute_function installation
}

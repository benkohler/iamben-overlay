# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit eutils python-single-r1

DESCRIPTION="CLI utility for quick access to current weather conditions and forecasts"
HOMEPAGE="http://fungi.yuggoth.org/${PN}"
SRC_URI="${HOMEPAGE}/src/${P}.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare () {
	sed -i -e 's/^#setpath/setpath/' ${PN}rc
	eapply_user
}

src_install() {
	doman ${PN}.1 ${PN}rc.5
	dodoc FAQ NEWS README
	python_fix_shebang ${PN}
	dobin ${PN}

	insinto /etc
	doins ${PN}rc

	insinto /usr/share/${PN}-util
	gzip airports places stations zctas zones
	doins airports.gz places.gz stations.gz zctas.gz zones.gz

	insinto $(python_get_sitedir)
	doins ${PN}.py
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 vcs-snapshot

COMMIT="2a84a53f4aac0175f75b77e3a73d5a68b6e20ac6"

DESCRIPTION="CLI utility for quick access to current weather conditions and forecasts"
HOMEPAGE="http://fungi.yuggoth.org/weather"
SRC_URI="https://www.yuggoth.org/gitweb?p=${PN}.git;a=snapshot;h=${COMMIT};sf=tgz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
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

	cp ${PN}.py "${D}"/$(python_get_sitedir)
}

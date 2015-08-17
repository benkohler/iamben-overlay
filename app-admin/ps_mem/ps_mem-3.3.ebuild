# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )
inherit python-r1 vcs-snapshot

COMMIT="73e97546ce9c06a1f3169d4232afc8eff8cb14ed"

DESCRIPTION="Memory usage analyzer"
HOMEPAGE="https://github.com/pixelb/${PN}"
SRC_URI="https://github.com/pixelb/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_install() {
	doman ${PN}.1
	dodoc README.md

	newsbin ${PN}.py ${PN}
	python_replicate_script "${D}/usr/sbin/${PN}"
}

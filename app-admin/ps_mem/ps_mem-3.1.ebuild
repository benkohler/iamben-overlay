# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )
inherit python-r1 vcs-snapshot

COMMIT="d7622c956e93881dad353f0b4ae812af9a64e3d1"

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

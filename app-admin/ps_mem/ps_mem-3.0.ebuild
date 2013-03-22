# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2} )
inherit python-r1

COMMIT_ID="51d2c7d5a1a69382158cfc87cb19a2fed2f48e8e"

DESCRIPTION="Memory usage analyzer"
HOMEPAGE="https://github.com/pixelb/scripts/commits/master/scripts/${PN}.py"
SRC_URI="https://raw.github.com/pixelb/scripts/${COMMIT_ID}/scripts/${PN}.py ->
${P}.py"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	newsbin "${DISTDIR}/${P}.py" "${PN}"
	python_replicate_script "${D}/usr/sbin/${PN}"
}

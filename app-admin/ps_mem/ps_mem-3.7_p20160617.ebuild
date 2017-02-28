# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )
inherit distutils-r1 vcs-snapshot

COMMIT="6a854910f54ac5dddb3356ae38fb8a00450d67b2"

DESCRIPTION="Memory usage analyzer"
HOMEPAGE="https://github.com/pixelb/${PN}"
SRC_URI="https://github.com/pixelb/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${PYTHON_DEPS}"

python_install() {
	distutils-r1_python_install --install-scripts="/usr/sbin"
}

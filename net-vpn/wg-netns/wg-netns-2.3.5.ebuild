# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12,13} )
inherit distutils-r1 systemd

DESCRIPTION="wg-quick with support for Linux network namespaces"
HOMEPAGE="https://github.com/dadevel/wg-netns"
SRC_URI="https://github.com/dadevel/wg-netns/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${PYTHON_DEPEND}"
RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	net-vpn/wireguard-tools
	sys-apps/iproute2
	${DEPEND}"

src_install() {
	distutils-r1_src_install
	systemd_dounit extras/wg-netns@.service extras/wg-resolve/wg-resolve@.{service,timer}
}

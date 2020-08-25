# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight, graphical wifi management utility for Linux"
HOMEPAGE="https://github.com/J-Lentz/iwgtk"
SRC_URI="https://github.com/J-Lentz/iwgtk/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}
	net-wireless/iwd"
BDEPEND=""

PATCHES=( "${FILESDIR}"/iwgtk-0.3-stdint-include.patch )

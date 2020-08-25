# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xdg

COMMIT=07f7f4e798c41eacc53b72f07a729393ab6acb9f

DESCRIPTION="Lightweight, graphical wifi management utility for Linux"
HOMEPAGE="https://github.com/J-Lentz/iwgtk"
SRC_URI="https://github.com/J-Lentz/iwgtk/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}
	net-wireless/iwd"

S="${WORKDIR}"/${PN}-${COMMIT}

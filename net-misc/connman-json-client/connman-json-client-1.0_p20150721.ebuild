# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools vcs-snapshot
COMMIT="3c34b2ee62d2e188090d20e7ed2fd94bab9c47f2"

DESCRIPTION="An ncurses UI for connman"
HOMEPAGE="https://github.com/eurogiciel-oss/connman-json-client"
SRC_URI="https://github.com/eurogiciel-oss/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/json-c
	>=sys-apps/dbus-1.4
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	default
	dobin connman_ncurses
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools

if [[ ${PV} != 9999 ]]; then
	inherit vcs-snapshot
	COMMIT="e4a8ddcca0870eb2ece5a7e3ea0296de9c86e5b2"
	SRC_URI="https://github.com/tbursztyka/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/tbursztyka/${PN}.git
		https://github.com/tbursztyka/${PN}.git"
	KEYWORDS=""
fi

DESCRIPTION="A full-featured GTK based trayicon UI for ConnMan"
HOMEPAGE="https://github.com/tbursztyka/connman-ui"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-misc/connman
	x11-libs/gtk+:3
	>=sys-apps/dbus-1.4"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

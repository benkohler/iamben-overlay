# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="An IRC and ICB client that runs under most UNIX platforms"
SRC_URI="http://ircii.warped.com//${P}.tar.bz2
	http://ircii.warped.com/old/${P}.tar.bz2"
HOMEPAGE="http://eterna.com.au/ircii/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6"

DEPEND="sys-libs/ncurses:0
	virtual/libiconv"
# This and irc-client both install /usr/bin/irc #247987
RDEPEND="${DEPEND}
	!net-irc/irc-client"

src_prepare() {
	eapply "${FILESDIR}/${PN}-manpage-path.patch"
	eapply_user
}

src_configure() {
	tc-export CC
	econf $(use_enable ipv6)
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	dodoc ChangeLog INSTALL NEWS README \
		doc/Copyright doc/crypto doc/VERSIONS doc/ctcp
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
inherit autotools git-r3 systemd

DESCRIPTION="Wireless daemon for linux"
HOMEPAGE="https://git.kernel.org/pub/scm/network/wireless/iwd.git/"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/network/wireless/iwd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="sys-apps/dbus"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	git-r3_src_unpack
	git clone git://git.kernel.org/pub/scm/libs/ell/ell.git "${WORKDIR}"/ell
}

src_prepare() {
	eapply "${FILESDIR}/iwd-find-pkg-config.patch"
	default
	eautoreconf
}

src_configure() {
	econf --sysconfdir=/etc/iwd --localstatedir=/var
}

src_install() {
	default
	keepdir /var/lib/${PN}
	systemd_dounit "${FILESDIR}/${PN}.service"
	dodoc -r test
}

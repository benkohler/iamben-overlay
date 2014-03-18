# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="SASL plugin for irssi"
HOMEPAGE="http://www.stack.nl/~jilles/irc/"
SRC_URI="http://freenode.net/sasl/${PN}.pl -> ${P}.pl"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Crypt-OpenSSL-Bignum
	dev-perl/crypt-dh
	dev-perl/Crypt-Blowfish
	virtual/perl-Math-BigInt
	virtual/perl-MIME-Base64"

S=${WORKDIR}

src_install() {
	insinto "/usr/share/${PN}"
	newins "${DISTDIR}/${P}.pl" "${PN}.pl"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "To install the script for your user: "
		elog "   mkdir -p ~/.irssi/scripts/"
		elog "   ln -s /usr/share/${PN}/${PN}.pl ~/.irssi/scripts/"
		elog "Then from irssi run: "
		elog "   /script load ${PN}"
		elog ""
		elog "More information on irssi script usage at http://scripts.irssi.org/"
	fi
}

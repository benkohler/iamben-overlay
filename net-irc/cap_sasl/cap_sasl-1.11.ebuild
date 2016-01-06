# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

COMMIT="370c39219fe59c48825ca7c6fa71da80cd61a43f"

DESCRIPTION="SASL plugin for irssi"
HOMEPAGE="http://scripts.irssi.org/"
SRC_URI="https://raw.githubusercontent.com/irssi/scripts.irssi.org/${COMMIT}/scripts/${PN}.pl -> ${P}.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-perl/CryptX-0.021
	dev-perl/Crypt-Blowfish
	dev-perl/crypt-dh
	dev-perl/Crypt-OpenSSL-Bignum
	virtual/perl-Math-BigInt
	virtual/perl-MIME-Base64
	net-irc/irssi[perl]"

S=${WORKDIR}

src_install() {
	insinto "/usr/share/${PN}"
	newins "${DISTDIR}/${P}.pl" "${PN}.pl"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "To install the script for your user and set it to autoload: "
		elog "   mkdir -p ~/.irssi/scripts/autorun/"
		elog "   ln -s /usr/share/${PN}/${PN}.pl ~/.irssi/scripts/autorun/"
		elog ""
		elog "Usage from irssi:"
		elog "   /sasl set <network> <user> <password> PLAIN"
		elog ""
		elog "For advanced configuration see:"
		elog "   https://freenode.net/sasl/sasl-irssi.shtml"
	fi
}

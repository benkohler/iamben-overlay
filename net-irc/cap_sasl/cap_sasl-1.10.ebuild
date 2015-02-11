# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

COMMIT="370c39219fe59c48825ca7c6fa71da80cd61a43f"

DESCRIPTION="SASL plugin for irssi"
HOMEPAGE="http://scripts.irssi.org/"
SRC_URI="https://raw.githubusercontent.com/irssi/scripts.irssi.org/${COMMIT}/scripts/${PN}.pl -> ${P}.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Crypt-OpenSSL-Bignum
	dev-perl/crypt-dh
	dev-perl/Crypt-Blowfish
	virtual/perl-Math-BigInt
	virtual/perl-MIME-Base64
	>=dev-perl/CryptX-0.021"

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

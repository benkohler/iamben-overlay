# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools git-r3 linux-info systemd

DESCRIPTION="Wireless daemon for linux"
HOMEPAGE="https://git.kernel.org/pub/scm/network/wireless/iwd.git/"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/network/wireless/iwd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+client +monitor"

RDEPEND="sys-apps/dbus
	client? ( sys-libs/readline:0= )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="
	~VLAN_8021Q
	~CRYPTO_USER_API_SKCIPHER
	~CRYPTO_USER_API_HASH
	~CRYPTO_RSA
	~CRYPTO_MD4
	~CRYPTO_SHA1
	~CRYPTO_SHA256
	~CRYPTO_ECB
	~CRYPTO_CMAC
	~KEY_DH_OPERATIONS
	~ASYMMETRIC_KEY_TYPE
	~ASYMMETRIC_PUBLIC_KEY_SUBTYPE
	~X509_CERTIFICATE_PARSER
	~PKCS7_MESSAGE_PARSER
"
pkg_setup() {
	check_extra_config
}

src_unpack() {
	git-r3_src_unpack
	git clone git://git.kernel.org/pub/scm/libs/ell/ell.git "${WORKDIR}"/ell
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --sysconfdir=/etc/iwd --localstatedir=/var \
		$(use_enable client) \
		$(use_enable monitor) \
		--disable-systemd-service
}

src_install() {
	default
	dodir /var/lib/${PN}

	newinitd "${FILESDIR}/iwd.initd" iwd
	systemd_dounit "${FILESDIR}/${PN}.service"

	exeinto /usr/share/iwd/scripts/
	doexe test/*
}

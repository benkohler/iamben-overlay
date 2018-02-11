# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools linux-info systemd

DESCRIPTION="Wireless daemon for linux"
HOMEPAGE="https://git.kernel.org/pub/scm/network/wireless/iwd.git/"
SRC_URI="https://www.kernel.org/pub/linux/network/wireless/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
}

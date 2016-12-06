# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit multilib systemd user

MY_PN="UniFi"

DESCRIPTION="Management Controller for UniFi APs"
HOMEPAGE="https://www.ubnt.com/download/unifi"
SRC_URI="http://dl.ubnt.com/unifi/5.3.8-d66ec0b93d/${MY_PN}.unix.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND=""
RDEPEND=">=dev-db/mongodb-2.0.0
	>=virtual/jre-1.7.0"

IUSE=""

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	enewgroup unifi
	enewuser unifi
}

src_install() {
	dodir /usr/$(get_libdir)/unifi
	dodir /var/log/unifi
	dodir /var/lib/unifi/work
	keepdir /var/lib/unifi/data
	insinto /usr/$(get_libdir)/unifi
	doins -r *
	dosym /var/lib/unifi/data /usr/$(get_libdir)/unifi/data
	dosym /var/lib/unifi/work /usr/$(get_libdir)/unifi/work
	dosym /var/log/unifi /usr/$(get_libdir)/unifi/logs
	echo "CONFIG_PROTECT=\"/var/lib/unifi/data/system.properties\"" > 99unifi
	doenvd 99unifi

	fowners unifi:unifi /var/log/unifi /var/lib/unifi

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd-r1" "${PN}"

	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_install_serviced "${FILESDIR}${PN}.service.conf"
}

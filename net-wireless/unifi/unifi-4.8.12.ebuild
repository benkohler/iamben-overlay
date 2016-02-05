# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit multilib systemd

MY_PN="UniFi"

DESCRIPTION="Management Controller for UniFi APs"
HOMEPAGE="https://www.ubnt.com/download/unifi"
SRC_URI="http://dl.ubnt.com/unifi/${PV}/${MY_PN}.unix.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"

DEPEND=""
RDEPEND="${DEPEND}
		  >=dev-db/mongodb-2.0.0
		  virtual/jre:1.7"
IUSE=""

S="${WORKDIR}/UniFi"

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
	
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
	
	systemd_dounit "${FILESDIR}"/${MY_PN}.service
}

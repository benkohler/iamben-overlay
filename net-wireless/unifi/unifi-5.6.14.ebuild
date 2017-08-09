# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib systemd user

MY_PN="UniFi"
# for stable candidates set RC_SUFFIX="-xxxxxxxxxx"
RC_SUFFIX="-f7a900184a"

DESCRIPTION="Management Controller for UniFi APs"
HOMEPAGE="https://www.ubnt.com/download/unifi"
SRC_URI="http://dl.ubnt.com/unifi/${PV}${RC_SUFFIX}/${MY_PN}.unix.zip -> ${P}.zip"

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
	enewuser unifi
	enewgroup unifi
}

src_install(){
	#dir with static data
	unifi_static="/usr/$(get_libdir)/unifi"
	#install static data
	dodir ${unifi_static}
	insinto ${unifi_static}
	doins -r *
	#prepare runtime-data dirs which live in /var but are symlinked from static
	#data dir, and are writable by unifi user
	dodir /var/log/unifi
	fowners unifi:unifi /var/log/unifi
	dosym ../../../../var/log/unifi ${unifi_static}/logs

	dodir /var/lib/unifi/work
	fowners unifi:unifi /var/lib/unifi/work
	dosym ../../../../var/lib/unifi/work ${unifi_static}/work

	keepdir /var/lib/unifi/data
	fowners unifi:unifi /var/lib/unifi/data
	dosym ../../../../var/lib/unifi/data ${unifi_static}/data

	echo "CONFIG_PROTECT=\"/var/lib/unifi/data/system.properties\"" > 99unifi
	doenvd 99unifi

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"

	systemd_newunit "${FILESDIR}/${PN}-r1.service" ${PN}.service
}

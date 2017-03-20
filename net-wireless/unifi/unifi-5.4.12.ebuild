# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib systemd

MY_PN="UniFi"
# for stable candidates set RC_SUFFIX="-xxxxxxxxxx"
RC_SUFFIX="-31875fd82e"

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

src_install(){
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

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"

	systemd_dounit "${FILESDIR}/${PN}.service"
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib systemd user

# for stable candidates set RC_SUFFIX="-xxxxxxxxxx"
RC_SUFFIX="-8261dc5066"

DESCRIPTION="Management Controller for UniFi APs"
HOMEPAGE="https://www.ubnt.com/download/unifi"
SRC_URI="http://dl.ubnt.com/unifi/${PV}${RC_SUFFIX}/UniFi.unix.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND=""
RDEPEND=">=dev-db/mongodb-2.0.0
	>=virtual/jre-1.7.0"

IUSE=""

S="${WORKDIR}/UniFi"

pkg_setup() {
	enewuser ${PN}
	enewgroup ${PN}
}

src_install(){
	static_dir="/usr/$(get_libdir)/${PN}"
	#dir with static data
	#install static data
	insinto ${static_dir}
	doins -r *
	#prepare runtime-data dirs which live in /var but are symlinked from static
	#data dir, and are writable by non-root user
	dodir /var/log/${PN}
	fowners ${PN}:${PN} /var/log/${PN}
	dosym ../../../var/log/${PN} ${static_dir}/logs

	dodir /var/lib/${PN}/work
	fowners ${PN}:${PN} /var/lib/${PN}/work
	dosym ../../../var/lib/${PN}/work ${static_dir}/work

	keepdir /var/lib/${PN}/data
	fowners ${PN}:${PN} /var/lib/${PN}/data
	dosym ../../../var/lib/${PN}/data ${static_dir}/data

	echo "CONFIG_PROTECT=\"/var/lib/${PN}/data/system.properties\"" > 99${PN}
	doenvd 99${PN}

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"

	systemd_newunit "${FILESDIR}/${PN}-r1.service" ${PN}.service
}

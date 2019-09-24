# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd user

MY_PV="${PV/_beta/-beta.}"
DESCRIPTION="UniFi Video Server"
HOMEPAGE="https://www.ubnt.com/download/unifi-video/"
SRC_URI="https://dl.ubnt.com/firmwares/ufv/v${MY_PV}/unifi-video.Ubuntu16.04_amd64.v${MY_PV}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="dev-db/mongodb
	dev-java/commons-daemon
	sys-apps/lsb-release
	sys-libs/libcap
	virtual/jre:1.8"

S=${WORKDIR}
QA_PREBUILT="usr/lib*/${PN}/lib/*.so usr/lib*/${PN}/bin/*"

pkg_setup() {
	enewuser ${PN}
	enewgroup ${PN}
}

src_unpack() {
	default
	unpack "${WORKDIR}"/data.tar.gz
}

src_prepare() {
	eapply "${FILESDIR}"/commons-daemon-move.patch
	sed -i usr/sbin/${PN} \
		-e '/require_root$/d' \
		-e '/update_limits$/d' \
		-e '/ulimit/d' \
		-e '/coredump_filter/d' || die
	default
}

src_install() {
	CODEPATH=/usr/lib/${PN}
	DATAPATH=/var/lib/${PN}
	LOGPATH=${DATAPATH}/logs
	VARLOGPATH=/var/log/${NAME}

	insinto /usr/lib
	doins -r usr/lib/${PN}
	into /usr
	dosbin usr/sbin/unifi-video

	dodir ${LOGPATH}
	fowners -R ${PN}:${PN} ${DATAPATH}
	dosym ${LOGPATH} ${VARLOGPATH}
	dosym ${LOGPATH} ${CODEPATH}/logs

	dosym ${DATAPATH} ${CODEPATH}/data

	cp -fH ${D}/${CODEPATH}/etc/system.properties ${D}/${DATAPATH}/system.properties

	fperms 500 \
		${CODEPATH}/bin/ubnt.* \
		${CODEPATH}/bin/evo* \
		/usr/sbin/${PN} \
		${CODEPATH}/tools/*
	fowners -R ${PN}:${PN} ${CODEPATH}
	fperms 0400 ${CODEPATH}/lib/*

	echo "CONFIG_PROTECT=\"${DATAPATH}/system.properties\"" > "${T}"/99${PN}
	doenvd "${T}"/99${PN}

	dosym /usr/bin/mongod ${CODEPATH}/bin/mongod

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	systemd_dounit "${FILESDIR}"/${PN}.service
}

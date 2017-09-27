# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd user

DESCRIPTION="UniFi Video Server"
HOMEPAGE="https://www.ubnt.com/download/unifi-video/"
SRC_URI="https://dl.ubnt.com/firmwares/ufv/v${PV}/unifi-video.Ubuntu16.04_amd64.v${PV}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-db/mongodb
	dev-java/commons-daemon
	sys-libs/libcap
	virtual/jre"

S=${WORKDIR}

pkg_setup() {
	enewuser unifi-video
	enewgroup unifi-video
}

src_unpack() {
	default
	unpack "${WORKDIR}"/data.tar.gz
}

src_prepare() {
	eapply "${FILESDIR}"/commons-daemon-move.patch
	default
}

src_install() {
	dataroot=/usr/$(get_libdir)/${PN}

	insinto ${dataroot}
	doins -r usr/lib/${PN}/*
	fperms -R +x ${dataroot}/bin
	dodir ${dataroot}/logs
	fowners unifi-video:unifi-video ${dataroot}/logs

	into /usr
	dosbin usr/sbin/${PN}
	dosym ../../../bin/mongod ${dataroot}/bin/mongod

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	systemd_dounit "${FILESDIR}"/${PN}.service
}

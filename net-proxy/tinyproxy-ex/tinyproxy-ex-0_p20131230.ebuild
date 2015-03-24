# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils systemd user vcs-snapshot

COMMIT="b17c39094e6fe0f15f275a0b9d22c75089d18931"
# "Upstream $PN"
UPN="tinyproxy"

DESCRIPTION="A fast light-weight HTTP proxy for POSIX operating systems."
HOMEPAGE="https://github.com/tenchman/tinyproxy-ex"
SRC_URI="https://github.com/tenchman/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ftp"

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND="${DEPEND}
	!net-proxy/tinyproxy"

pkg_setup() {
    enewgroup ${UPN}
    enewuser ${UPN} "" "" "" ${UPN}
}

src_prepare () {
	sed -i \
		-e "s|nobody|${UPN}|g" \
		-e "s|nogroup|${UPN}|g" \
		-e 's|/var/run/|/run/|g' \
		doc/${PN}.conf.in || die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use ftp FTP_SUPPORT)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd ${FILESDIR}/${PN}.initd tinyproxy-ex
	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_dotmpfilesd "${FILESDIR}/${PN}.tmpfiles.conf"
}

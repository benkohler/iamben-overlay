# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils systemd user vcs-snapshot

COMMIT="940bacb36b1008394ab8eb968c7f7691f3f9d75f"
# "Upstream $PN"
UPN="tinyproxy"

DESCRIPTION="A fast light-weight HTTP proxy for POSIX operating systems."
HOMEPAGE="https://github.com/tenchman/tinyproxy-ex"
SRC_URI="https://github.com/tenchman/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="diet filter ftp proctitle upstream"

DEPEND="sys-devel/bison
	sys-devel/flex
	diet? ( dev-libs/dietlibc )"
RDEPEND="diet? ( dev-libs/dietlibc )
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

		eapply "${FILESDIR}/tinyproxy-ex_dietlibc-fix.patch"
		eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DUSE_DIET="$(usex diet)"
		-DFILTER_SUPPORT="$(usex filter)"
		-DFTP_SUPPORT="$(usex ftp)"
		-DPROCTITLE_SUPPORT="$(usex proctitle)"
		-DUPSTREAM_SUPPORT="$(usex upstream)"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}/${PN}.initd" tinyproxy-ex
	systemd_dounit "${FILESDIR}/${PN}.service"
	systemd_dotmpfilesd "${FILESDIR}/${PN}.tmpfiles.conf"
}

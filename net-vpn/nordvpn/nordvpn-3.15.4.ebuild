# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg-utils tmpfiles

MY_PV=$(ver_rs 3 '-')

DESCRIPTION="NordVPN native client"
HOMEPAGE="https://nordvpn.com"
SRC_URI="https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn_${MY_PV}_amd64.deb"

LICENSE="NordVPN"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="ipsymlink"

# TODO: verify that list of RDEPEND is complete
RDEPEND="net-misc/networkmanager
		net-vpn/networkmanager-openvpn
		sys-apps/iproute2
		acct-group/nordvpn"

RESTRICT="strip"
S="${WORKDIR}"

src_unpack() {
	# Unpack Debian package containing application's files
	unpack_deb ${A}
	gzip "${S}"/usr/share/doc/nordvpn/changelog.gz -d
	gzip "${S}"/usr/share/man/man1/nordvpn.1.gz -d
}

src_install() {
	newinitd "${FILESDIR}/nordvpn.initd" ${PN}

	dobin usr/bin/nordvpn
	dosbin usr/sbin/nordvpnd

	insinto /var/lib/
	doins -r var/lib/nordvpn

	fowners root:nordvpn /var/lib/nordvpn/openvpn
	fperms 0550 /var/lib/nordvpn/openvpn

	insinto /usr/share/
	doins -r usr/share/applications
	doins -r usr/share/zsh
	doins -r usr/share/bash-completion
	doins -r usr/share/icons

	dodoc usr/share/doc/nordvpn/changelog
	doman usr/share/man/man1/nordvpn.1

	if use ipsymlink ; then
		dosym ../bin/ip /sbin/ip
	fi

	dotmpfiles "${FILESDIR}/nordvpn.conf"
}

pkg_postinst (){
	if use !ipsymlink ; then
		elog "nordvpnd expects to find ip command in /sbin folder iproute2 package installs it in /bin please make sure to create a symlink: ln -s /bin/ip /sbin/ip"
	fi
	xdg_desktop_database_update
	xdg_icon_cache_update
	tmpfiles_process nordvpn.conf
}

pkg_postrm (){
	xdg_desktop_database_update
	xdg_icon_cache_update
}

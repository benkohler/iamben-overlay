# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/barry/barry-0.17.1-r1.ebuild,v 1.1 2012/08/11 16:45:51 ssuominen Exp $

EAPI="4"
WX_GTK_VER="2.8"

inherit autotools-utils bash-completion eutils toolchain-funcs wxwidgets

DESCRIPTION="Sync, backup, program management, and charging for BlackBerry devices"
HOMEPAGE="http://www.netdirect.ca/software/packages/barry/"
SRC_URI="mirror://sourceforge/barry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+backup boost +desktop doc eds opensync nls static-libs +watch"

#AUTOMAGIC DEPS ON
# evolution-data-server
# libsdl
# libopensync

RDEPEND="
	dev-libs/glib:2
	virtual/libusb:0
	dev-libs/openssl
	sys-libs/zlib
	>=dev-libs/libtar-1.2.11-r2
	boost?	( >=dev-libs/boost-1.33 )
	desktop? (	dev-cpp/glibmm:2
				>=net-libs/libgcal-0.9.6
				dev-cpp/libxmlpp:2.6
				x11-libs/wxGTK:2.8 )
	backup?	( dev-cpp/glibmm:2
			  dev-cpp/gtkmm:2.4
			  dev-cpp/libglademm:2.4 )
	opensync? ( eds? ( gnome-extra/evolution-data-server )
				~app-pda/libopensync-0.22 )
	watch? ( media-libs/libsdl )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc?	( >=app-doc/doxygen-1.5.6 )
	nls?	( >=sys-devel/gettext-0.17 )"

DOCS=(AUTHORS ChangeLog NEWS README TODO)

src_configure() {
	myeconfargs=(
		$(use_enable boost)
		$(use_enable backup gui)
		$(use_enable desktop)
		$(use_enable nls)
		$(use_enable opensync opensync-plugin)
		--disable-rpath
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use doc ; then
		cd "${S}"
		doxygen || die
	fi
}

src_install() {
	autotools-utils_src_install
	use watch || rm "${D}"/usr/bin/bwatch &> /dev/null
	# docs
	rm -rf "${S}"/doc/www/*.php
	rm -rf "${S}"/doc/www/*.sh
	find "${S}"/doc/www/doxygen/html -name "*.map" -size 0 -exec rm -f {} +

	if use doc; then
		dohtml "${S}"/doc/www/doxygen/html/*
	fi

	rm -rf "${S}"/doc/www
	dodoc -r "${S}"/doc/*

	#  udev rules
	local udevdir=/lib/udev
	has_version sys-fs/udev && udevdir="$($(tc-getPKG_CONFIG) --variable=udevdir udev)"
	insinto "${udevdir}"/rules.d
	doins "${S}"/udev/10-blackberry.rules
	sed -i -e 's:plugdev:usb:g' "${S}"/udev/99-blackberry-perms.rules || die
	doins "${S}"/udev/99-blackberry-perms.rules

	#  blacklist for BERRY_CHARGE kernel module
	insinto /etc/modprobe.d
	doins "${S}"/modprobe/blacklist-berry_charge.conf

	# pppd options files
	docinto "${DOCDIR}"/ppp/
	dodoc "${S}"/ppp/*

	BASHCOMPFILES="${S}/bash/btool ${S}/bash/bjavaloader"
	dobashcompletion

	if use backup; then
		domenu "${S}"/menu/barrybackup.desktop
		newicon -s scalable "${S}"/logo/barry_logo_icon.svg barry_backup_menu_icon.svg
		newicon -s 48 "${S}"/logo/barry_logo_icon.png barry_backup_menu_icon.png
	fi
	if use desktop; then
		domenu "${S}"/menu/barrydesktop.desktop
		newicon -s scalable "${S}"/logo/barry_logo_icon.svg barry_desktop_menu_icon.svg
		newicon -s 48 "${S}"/logo/barry_logo_icon.png barry_desktop_menu_icon.png
	fi
}

pkg_postinst() {
	einfo
	elog "Barry requires you to be a member of the \"usb\" group."
	einfo
	bash-completion_pkg_postinst
	ewarn
	ewarn "Barry and the in-kernel module 'BERRY_CHARGE' are incompatible."
	ewarn
}

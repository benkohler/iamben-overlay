# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PN="BeerSmith2"

DESCRIPTION="BeerSmith Home Brewing Software"
HOMEPAGE="http://www.beersmith.com/"
SRC_URI="x86? ( https://s3.amazonaws.com/BeerSmith2-1/BeerSmith-${PV}.deb ) 
	amd64? ( https://s3.amazonaws.com/BeerSmith2-1/BeerSmith-${PV}_amd64.deb )"

LICENSE="BeerSmith
	wxWinLL-3
	GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="media-libs/libpng:1.2
	x11-libs/libX11
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/libSM
	x11-libs/pango
	x11-libs/gtk+:2"

S="${WORKDIR}"

src_unpack() {
	unpack ${A} ./data.tar.gz
}

src_install() {
	into /opt
	dobin usr/bin/beersmith2
	into /opt/${PN}
	dolib usr/lib/*

	insinto /usr/share/${MY_PN}
	cd usr/share/${MY_PN}
	doins -r *.bsmx *.xml *.bsopt Reports Updates help

	insinto /usr/share/${MY_PN}/icons
	doins icons/*.png icons/*.gif

	cd "${S}"
	sed -i 's#/usr/bin/##' usr/share/applications/beersmith2.desktop
	domenu usr/share/applications/beersmith2.desktop
	for size in 16 24 32 48 64 128 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		doins usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png
	done
	doicon usr/share/icons/hicolor/48x48/apps/${PN}.png

	echo -n "LDPATH=/opt/${PN}/$(get_libdir)/" > "${T}/99beersmith"
	doenvd "${T}/99beersmith"
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
WX_GTK_VER="2.9"

inherit eutils unpacker wxwidgets

MY_PN="BeerSmith"

DESCRIPTION="BeerSmith Home Brewing Software"
HOMEPAGE="http://www.beersmith.com/"
SRC_URI="x86? ( https://s3.amazonaws.com/${MY_PN}2-1/${MY_PN}-${PV}.deb )
  amd64? ( https://s3.amazonaws.com/${MY_PN}2-1/${MY_PN}-${PV}_amd64.deb )"

LICENSE="${MY_PN}
	GPL-2"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="media-libs/libpng:1.5
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/pango
	=x11-libs/wxGTK-2.9.3*[X]"

S="${WORKDIR}"

src_install() {
	into /opt
	dobin usr/bin/beersmith2

	insinto /usr/share/${MY_PN}2
	doins -r usr/share/${MY_PN}2/{*.bsmx,*.xml,*.bsopt,Reports,Updates,help}

	insinto /usr/share/${MY_PN}2/icons
	doins usr/share/${MY_PN}2/icons/*.{gif,png}

	sed -i 's#/usr/bin/##' usr/share/applications/beersmith2.desktop
	domenu usr/share/applications/beersmith2.desktop
	for size in 16 24 32 48 64 128 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		doins usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png
	done
}

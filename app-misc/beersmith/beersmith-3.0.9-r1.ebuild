# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker

MY_PN="BeerSmith"
MJ_VER="$(ver_cut 1)"

DESCRIPTION="BeerSmith Home Brewing Software"
HOMEPAGE="http://www.beersmith.com/"
SRC_URI="https://s3.amazonaws.com/beersmith-${MJ_VER}/BeerSmith-${PV}_amd64.deb"

LICENSE="${MY_PN}
	GPL-2"

SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="dev-libs/glib:2
	dev-libs/openssl:0/1.1
	media-libs/fontconfig
	media-libs/libpng:0/16
	net-libs/webkit-gtk:4/37
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/pango
	"

S="${WORKDIR}"
QA_PREBUILT="opt/bin/beersmith${MJ_VER}"

src_install() {
	into /opt
	dobin usr/bin/beersmith${MJ_VER}

	insinto /usr/share/${MY_PN}${MJ_VER}
	doins -r usr/share/${MY_PN}${MJ_VER}/{*.bsmx,*.xml,*.bsopt,Reports,Updates,help}

	insinto /usr/share/${MY_PN}${MJ_VER}/icons
	doins usr/share/${MY_PN}${MJ_VER}/icons/*.{gif,png}

	sed -i \
		-e 's#/usr/bin/##' \
		-e '/^Categories/ s/$/;/' \
		usr/share/applications/beersmith3.desktop
	domenu usr/share/applications/beersmith3.desktop

	for size in 16 24 32 48 64 128 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		doins usr/share/icons/hicolor/${size}x${size}/apps/${PN}${MJ_VER}.png
	done
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker

DESCRIPTION="BeerSmith Home Brewing Software"
HOMEPAGE="http://www.beersmith.com/"
SRC_URI="https://beersmith3-1.s3.amazonaws.com/BeerSmith-${PV}_amd64.deb "

LICENSE="BeerSmith GPL-2"

SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="
	app-arch/brotli:0/1
	dev-libs/glib:2
	dev-libs/openssl:0/1.1
	media-libs/fontconfig
	media-libs/libpng:0/16
	net-libs/libpsl:0
	net-libs/webkit-gtk:4/37
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/pango
"

S="${WORKDIR}"
QA_PREBUILT="opt/bin/beersmith3"

src_install() {
	into /opt
	dobin usr/bin/beersmith3

	insinto /usr/share/BeerSmith3
	doins -r usr/share/BeerSmith3/{*.bsmx,*.xml,*.bsopt,Reports,Updates,help}

	insinto /usr/share/BeerSmith3/icons
	doins usr/share/BeerSmith3/icons/*.{gif,png}

	sed -i \
		-e 's#/usr/bin/##' \
		-e '/^Categories/ s/$/;/' \
		usr/share/applications/beersmith3.desktop
	domenu usr/share/applications/beersmith3.desktop

	for size in 16 24 32 48 64 128 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		doins usr/share/icons/hicolor/${size}x${size}/apps/beersmith3.png
	done
}

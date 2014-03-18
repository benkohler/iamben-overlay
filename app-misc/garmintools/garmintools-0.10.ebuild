# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A Linux interface to the Garmin Forerunner GPS units"
HOMEPAGE="http://code.google.com/p/garmintools/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

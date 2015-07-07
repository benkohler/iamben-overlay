# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils vcs-snapshot

COMMIT="00c4cf39d60e9326719adc818b4a00841d2305b9"

DESCRIPTION="LXQt system-tray applet for connman"
HOMEPAGE="https://github.com/surlykke/lxqt-connman-applet"
SRC_URI="https://github.com/surlykke/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/linguist-tools
	dev-qt/qtdbus:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	lxqt-base/liblxqt"
RDEPEND="${DEPEND}"

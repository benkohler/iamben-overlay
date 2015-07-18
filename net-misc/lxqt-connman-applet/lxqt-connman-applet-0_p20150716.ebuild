# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils eutils vcs-snapshot

COMMIT="d01e7d31b82ba4d7d16f1686ec2c9a3a57a40016"

DESCRIPTION="LXQt system-tray applet for connman"
HOMEPAGE="https://github.com/surlykke/lxqt-connman-applet"
SRC_URI="https://github.com/surlykke/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	lxqt-base/liblxqt"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	>=dev-util/cmake-3.0.2"

src_prepare() {
	epatch "${FILESDIR}"/build-fix-hack.patch
	cmake-utils_src_prepare
}

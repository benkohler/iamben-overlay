# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils vcs-snapshot

COMMIT="940493ce509bb2784738d547cc27df677b4835a2"

DESCRIPTION="LXQt system-tray applet for connman"
HOMEPAGE="https://github.com/surlykke/lxqt-connman-applet"
SRC_URI="https://github.com/surlykke/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	>lxqt-base/liblxqt-0.9.0"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

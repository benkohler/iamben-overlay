# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils vcs-snapshot

COMMIT="41126c9d9c5c348624488398aff24126be49a6c3"

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

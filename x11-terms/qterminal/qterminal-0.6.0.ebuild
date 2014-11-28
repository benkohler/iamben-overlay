# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/qterminal/qterminal-0.5.0_p20140913.ebuild,v 1.2 2014/09/27 11:38:55 maekke Exp $

EAPI="5"

inherit cmake-utils

DESCRIPTION="Qt-based multitab terminal emulator"
HOMEPAGE="https://github.com/qterminal/qterminal"
SRC_URI="https://github.com/qterminal/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug qt5"

DEPEND="
       !qt5? (
               dev-qt/qtcore:4
               dev-qt/qtgui:4
               x11-libs/libqxt
               x11-libs/qtermwidget[-qt5]
       )
       qt5? (
               dev-qt/qtcore:5
               dev-qt/qtgui:5
               dev-qt/linguist-tools:5
               >=x11-libs/qtermwidget-0.6.0[qt5]
		)"
RDEPEND="${DEPEND}"

src_configure() {
       local mycmakeargs=(
               $(cmake-utils_use_use qt5 QT5)
               $(cmake-utils_use_use !qt5 SYSTEM_QXT)
       )
       cmake-utils_src_configure
}

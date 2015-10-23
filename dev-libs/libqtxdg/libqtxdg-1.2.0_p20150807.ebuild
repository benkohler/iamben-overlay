# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	COMMIT="d1bae674d698be6e2949b65c99ab06093cbe9600"
	inherit vcs-snapshot
	SRC_URI="https://github.com/lxde/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="test"

CDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	test? ( dev-qt/qttest:5 )
"
RDEPEND="${CDEPEND}
	x11-misc/xdg-utils
"

src_configure() {
	local mycmakeargs=(
		-DUSE_QT4=OFF
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

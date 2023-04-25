# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils

DESCRIPTION="Graphical interface for easy operation of fsarchiver."
HOMEPAGE="https://github.com/DieterBaum/qt-fsarchiver"
SRC_URI="mirror://sourceforge/${PN}/${PN}-$(ver_rs 3 -).tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="app-arch/bzip2
	app-arch/lz4
	app-arch/xz-utils
	app-arch/zstd
	dev-libs/libgcrypt:=
	dev-libs/lzo
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	sys-apps/util-linux
	sys-fs/e2fsprogs
	sys-libs/zlib"
RDEPEND="${COMMON_DEPEND}
	app-backup/fsarchiver[lzma,lzo]
	app-backup/qt-fsarchiver-terminal"

DEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}

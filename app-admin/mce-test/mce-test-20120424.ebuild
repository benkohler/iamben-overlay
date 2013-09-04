# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vcs-snapshot eutils toolchain-funcs

COMMITID="a4c080bd1556e1f888754305ffb9fe9e5090e9b9"

DESCRIPTION="A tool to log and decode Machine Check Exceptions"
HOMEPAGE="http://mcelog.org/"
SRC_URI="https://github.com/andikleen/${PN}/tarball/${COMMITID} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}/mce-test-fortify-source-fix.patch"
	epatch "${FILESDIR}/mce-test-pthread-fix.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake install
	dobin bin/*
	dodoc -r doc/*
	dolib lib/*
}

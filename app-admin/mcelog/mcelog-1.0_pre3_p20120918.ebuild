# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vcs-snapshot linux-info eutils toolchain-funcs

COMMITID="0f5d0238ca7fb963a687a3c50c96c5f37a599c6b"

DESCRIPTION="A tool to log and decode Machine Check Exceptions"
HOMEPAGE="http://mcelog.org/"
SRC_URI="https://github.com/andikleen/${PN}/tarball/${COMMITID} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

CONFIG_CHECK="~X86_MCE"

# test suite needs mce-inject, we don't have a package for it yet
#RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8_pre1-timestamp-mcelog.patch

	sed -i \
		-e 's:-g:${CFLAGS}:g' \
		-e 's:\tgcc:\t$(CC):g' Makefile || die "sed makefile failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dosbin mcelog
	doman mcelog.8

	insinto /etc/cron.daily
	newins mcelog.cron mcelog

	insinto /etc/logrotate.d/
	newins mcelog.logrotate mcelog

	newinitd "${FILESDIR}"/mcelog.init mcelog

	dodoc CHANGES README TODO *.pdf
}

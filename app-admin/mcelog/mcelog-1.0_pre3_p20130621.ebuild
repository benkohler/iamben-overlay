# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit vcs-snapshot linux-info eutils toolchain-funcs

COMMITID="b842ecb44965722ecd67bed1ed9d900073e3313f"

DESCRIPTION="A tool to log and decode Machine Check Exceptions"
HOMEPAGE="http://mcelog.org/"
SRC_URI="https://github.com/andikleen/${PN}/tarball/${COMMITID} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="test? ( app-admin/mce-inject )"

CONFIG_CHECK="~X86_MCE"

# test suite seems broken even with mce-inject available
RESTRICT="test"

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

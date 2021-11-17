# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Files for /etc/profile.d/ to be shared on all machines"
HOMEPAGE="https://github.com/iamben-overlay/app-misc/iamben-profiled"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	exeinto /etc/profile.d
	doexe "${FILESDIR}/aliases.sh"
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Files for /etc/profile.d/ to be shared on all machines"
HOMEPAGE="https://github.com/iamben-overlay/app-misc/iamben-profiled"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	echo 'alias upd="emerge -uDNav world --newrepo --changed-deps"' >> \
		aliases.sh
	echo 'alias mt="qlop -tHvg"' >> aliases.sh
}

src_install() {
	exeinto /etc/profile.d
	doexe *
}

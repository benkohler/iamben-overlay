# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="SquidAnalyzer"
HOMEPAGE="http://squidanalyzer.darold.net/"
SRC_URI="mirror://sourceforge/squid-report/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/GD
	dev-perl/GDGraph
	dev-perl/GD-Graph3d"
RDEPEND="${DEPEND}"

src_configure() {
	perl Makefile.PL \
	DESTDIR="${D}" \
	BINDIR=/usr/bin \
	MANDIR=/usr/share/man/man3 \
	BASEDIR=$(get_libdir) \
	HTMLDIR=/var/www/localhost/htdocs
}

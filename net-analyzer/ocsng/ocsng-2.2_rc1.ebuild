# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="OCS Inventory NG"
HOMEPAGE="http://www.ocsinventory-ng.org/en/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=virtual/mysql-4.1
	>=dev-lang/perl-5.8
	>www-servers/apache-2.4[apache2_modules_alias,apache2_modules_authn_core,apache2_modules_authn_core,apache2_modules_authz_core,apache2_modules_authz_host,apache2_modules_authz_user,apache2_modules_dir,apache2_modules_include,apache2_modules_mime,apache2_modules_socache_shmcb,apache2_modules_unixd]
	>=www-apache/mod_perl-1.29
	>=dev-lang/php-4.3.2[zip,apache2,gd]
	>=dev-perl/XML-Simple-2.12
	virtual/perl-IO-Compress
	virtual/perl-libnet
	>=dev-perl/DBI-1.40
	>=dev-perl/DBD-mysql-2.9004
	>=dev-perl/Apache-DBI-0.93
	>=dev-perl/Net-IP-1.21
	dev-perl/SOAP-Lite
"
RDEPEND="${DEPEND}"

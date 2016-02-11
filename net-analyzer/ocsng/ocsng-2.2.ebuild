# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="OCS Inventory NG"
HOMEPAGE="http://www.ocsinventory-ng.org/en/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/mysql
	dev-lang/php:*[apache2,gd,mysql,zip]
	dev-lang/perl
	dev-perl/Archive-Zip
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/Apache-DBI
	dev-perl/Net-IP
	dev-perl/SOAP-Lite
	dev-perl/XML-Entities
	dev-perl/XML-Simple
	virtual/perl-IO-Compress
	virtual/perl-libnet
	www-apache/mod_perl
	>www-servers/apache-2.4[apache2_modules_alias,apache2_modules_authn_core,apache2_modules_authn_core,apache2_modules_authz_core,apache2_modules_authz_host,apache2_modules_authz_user,apache2_modules_dir,apache2_modules_include,apache2_modules_mime,apache2_modules_socache_shmcb,apache2_modules_unixd]
"
RDEPEND="${DEPEND}"

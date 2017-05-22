# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Meta ebuild for LXQt, the Lightweight Desktop Environment"
HOMEPAGE="http://lxqt.org/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+about admin +filemanager +icons lightdm lximage minimal +oxygen +policykit
	powermanagement sddm ssh-askpass sudo"
REQUIRED_USE="oxygen? ( icons )"

RDEPEND="
	>=lxde-base/lxmenu-data-0.1.2
	>=lxqt-base/lxqt-common-${PV}
	>=lxqt-base/lxqt-config-${PV}
	>=lxqt-base/lxqt-globalkeys-${PV}
	>=lxqt-base/lxqt-notificationd-${PV}
	>=lxqt-base/lxqt-panel-${PV}
	>=lxqt-base/lxqt-qtplugin-${PV}
	>=lxqt-base/lxqt-runner-${PV}
	>=lxqt-base/lxqt-session-${PV}
	virtual/ttf-fonts
	about? ( >=lxqt-base/lxqt-about-${PV} )
	admin? ( >=lxqt-base/lxqt-admin-${PV} )
	filemanager? ( >=x11-misc/pcmanfm-qt-${PV} )
	icons? ( oxygen? ( kde-frameworks/oxygen-icons )
		!oxygen? ( virtual/freedesktop-icon-theme ) )
	lightdm? ( x11-misc/lightdm )
	lximage? ( media-gfx/lximage-qt )
	!minimal? ( x11-wm/openbox
		x11-misc/obconf-qt )
	policykit? ( >=lxqt-base/lxqt-policykit-${PV}
		|| ( sys-auth/consolekit[policykit(-)]
			sys-apps/systemd[policykit(-)] ) )
	powermanagement? ( >=lxqt-base/lxqt-powermanagement-${PV} )
	sddm? ( >=x11-misc/sddm-0.11.0 )
	ssh-askpass? ( >=lxqt-base/lxqt-openssh-askpass-${PV} )
	sudo? ( >=lxqt-base/lxqt-sudo-${PV} )"

# Note: we prefer kde-frameworks/oxygen-icons over other icon sets, as the initial
# install expects oxygen icons, until the user specifies otherwise (bug 543380)

S="${WORKDIR}"

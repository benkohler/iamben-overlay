# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://github.com/Aetf/kmscon/releases/download/v${PV}/${P}.tar.xz"
KEYWORDS="~amd64 ~x86"

inherit meson flag-o-matic systemd toolchain-funcs

DESCRIPTION="KMS/DRM based virtual Console Emulator"
HOMEPAGE="https://github.com/Aetf/kmscon"

LICENSE="MIT LGPL-2.1 BSD-2"
SLOT="0"
IUSE="debug doc +drm +fbdev +gles2 +pango pixman static-libs systemd +unicode"

COMMON_DEPEND="
	>=virtual/udev-172
	x11-libs/libxkbcommon
	>=dev-libs/libtsm-4.0.0:=
	media-libs/mesa[X(+)]
	drm? ( x11-libs/libdrm
		>=media-libs/mesa-8.0.3[egl(+),gbm(+)] )
	gles2? ( >=media-libs/mesa-8.0.3[gles2] )
	systemd? ( sys-apps/systemd )
	pango? ( x11-libs/pango dev-libs/glib:2 )
	pixman? ( x11-libs/pixman )"
RDEPEND="${COMMON_DEPEND}
	x11-misc/xkeyboard-config"
DEPEND="${COMMON_DEPEND}
	x11-base/xorg-proto"
BDEPEND="virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

REQUIRED_USE="gles2? ( drm )"

src_prepare() {
	default
	eautoreconf

	export CC_FOR_BUILD="$(tc-getBUILD_CC)"
}

src_configure() {

	# kmscon sets -ffast-math unconditionally
	strip-flags

	local emesonargs=(
		$(meson_use debug)
		$(meson_use systemd multi-seat)
		$(meson_use fbdev video_fbdev)
		$(meson_use drm video_drm2d)
		$(meson_use drm video_drm3d)
		$(meson_use unicode font_unifont)
		$(meson_use pango font_pango)
		-Drenderer_bbulk=true
		$(meson_use gles2 renderer_gltex)
		$(meson_use pixman renderer_pixman)
		-Dsession_dummy=true
		-Dsession_terminal=true
	)

	meson_src_configure

}

src_install() {
	emake DESTDIR="${D}" install
	systemd_dounit "${S}/docs"/kmscon{,vt@}.service

	insinto /usr/share/${PN}
	doins -r fblog

	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst() {
	grep -e "^ERASECHAR" "${EROOT}"/etc/login.defs && \
	ewarn "It is recommended that you comment out the ERASECHAR line in" && \
	ewarn " /etc/login.defs for proper backspace functionality at the" && \
	ewarn " kmscon login prompt.  For details see:" && \
	ewarn "https://github.com/dvdhrm/kmscon/issues/69#issuecomment-13827797"
}

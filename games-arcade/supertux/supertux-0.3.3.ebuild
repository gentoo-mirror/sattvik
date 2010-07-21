# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base games cmake-utils

DESCRIPTION="Classic 2D jump'n run sidescroller game similar to SuperMario: Milestone 2"
HOMEPAGE="http://supertux.lethargik.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/glew
	media-libs/libsdl
	media-libs/sdl-image
	dev-games/physfs
	media-libs/openal"
DEPEND="${RDEPEND}
	dev-libs/boost"

RESTRICT="mirror"

PATCHES=( "${FILESDIR}/0.3.3-fs-layout.patch"
	"${FILESDIR}/desktop.patch" )

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}

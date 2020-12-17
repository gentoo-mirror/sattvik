# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
WX_GTK_VER="3.0-gtk3"

inherit desktop perl-module cmake wxwidgets

DESCRIPTION="G-code generator for 3D printers"
HOMEPAGE="https://www.prusa3d.com/prusaslicer/"
SRC_URI="https://github.com/prusa3d/PrusaSlicer/archive/version_${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3 CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui test"

RDEPEND="!media-gfx/slic3r
	>=dev-libs/boost-1.55[threads]
	dev-cpp/eigen
	dev-cpp/gtest
	>=dev-cpp/tbb-2020.2
	dev-libs/cereal
	dev-libs/expat
	dev-libs/openssl
	>=media-gfx/openvdb-5.2.0-r2
	media-libs/glew:0
	net-misc/curl
	sci-libs/nlopt
	>=sci-mathematics/cgal-4.14
	x11-libs/wxGTK:${WX_GTK_VER}"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PrusaSlicer-version_${PV/_/-}"

PATCHES=(
	"${FILESDIR}/${P}-boost-1.73.patch"
	"${FILESDIR}/${P}-include-atomic.patch"
)

src_configure() {
	setup-wxwidgets
	local mycmakeargs=(
		-DSLIC3R_WX_STABLE=1
		-DSLIC3R_GUI=$(usex gui 1 0)
		-DSLIC3R_FHS=1
		-DSLIC3R_STATIC=0
		-DSLIC3R_GTK=3
		-DSLIC3R_PERL_XS=0
		-DSLIC3R_BUILD_SANDBOXES=0
		-DSLIC3R_BUILD_TESTS=$(usex test 1 0)
		-DSLIC3R_PCH=0
	)
	cmake_src_configure
}

src_test() {
	perl-module_src_test
	pushd .. || die
	prove -Ixs/blib/arch -Ixs/blib/lib/ t/ || die "Tests failed"
	popd || die
}

src_install() {
	cmake_src_install

	(
		dodir "/usr/share/pixmaps";
		dosym "../PrusaSlicer/icons/PrusaSlicer_192px.png" "/usr/share/pixmaps/prusa-slicer.png"
	)

	make_desktop_entry "prusa-slicer %F" "PrusaSlicer" "prusa-slicer" \
		"Graphics;3DGraphics;Engineering;Development" \
		"MimeType=model/stl;application/xml;application/prs.wavefront-obj;application/vnd.ms-3mfdocument;"
}

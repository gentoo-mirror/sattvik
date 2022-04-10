# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils udev

if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psieg/Lightpack"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/psieg/Lightpack/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Prismatik is an open-source software to control Lightpack devices"
HOMEPAGE="http://lightpack.tv"

LICENSE="GPL-3"
SLOT="0"
IUSE="pulseaudio"

BDEPEND="
	dev-qt/linguist-tools:5
	"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtserialport:5
	dev-qt/qtwidgets:5
	media-libs/mesa
	virtual/libusb:1
	virtual/udev
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${P}/Software"

src_prepare() {
	rm -rf qtserialport
	sed -e "/qtserialport/d" -i Lightpack.pro || die
	if use pulseaudio ; then
		cp build-vars.prf.default build-vars.prf || die
	else
		sed -e "/PULSEAUDIO_SUPPORT/d"  build-vars.prf.default > build-vars.prf || die
	fi
	default
}

src_configure() {
	eqmake5 Lightpack.pro
}

src_install() {
	newbin bin/Prismatik ${PN}

	domenu "${FILESDIR}/${PN}.desktop"

	insinto /usr/share/
	doins -r dist_linux/package_template/usr/share/{icons,pixmaps}

	udev_dorules dist_linux/package_template/etc/udev/rules.d/93-lightpack.rules
}

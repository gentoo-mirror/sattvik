# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils udev

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
IUSE=""

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
	default
}

src_configure() {
	eqmake5 Lightpack.pro
}

src_install() {
	newbin bin/Prismatik ${PN}

	domenu dist_linux/deb/usr/share/applications/${PN}.desktop

	insinto /usr/share/
	doins -r dist_linux/deb/usr/share/{icons,pixmaps}

	udev_dorules dist_linux/deb/etc/udev/rules.d/93-lightpack.rules
}

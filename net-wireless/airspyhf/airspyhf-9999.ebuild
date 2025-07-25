# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev git-r3

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"

EGIT_REPO_URI="https://github.com/airspy/airspyhf.git"
LICENSE="BSD"

SLOT="0/${PV}"

KEYWORDS=""

DEPEND="
	virtual/libusb:0
	virtual/udev
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	cmake_src_configure
}

src_install() {
	default
	cmake_src_install
	udev_dorules tools/52-airspyhf.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

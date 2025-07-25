# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"

SRC_URI="https://github.com/airspy/airspyhf/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"

SLOT="0/${PV}"

KEYWORDS="~amd64 ~arm ~riscv ~x86"

DEPEND="
	virtual/libusb:0
	virtual/udev
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-1.6.8-support-c23.patch"
)

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

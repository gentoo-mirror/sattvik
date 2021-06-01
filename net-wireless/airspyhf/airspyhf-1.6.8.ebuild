# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/airspy/airspyhf.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/airspy/airspyhf/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="BSD"
SLOT="0/${PV}"

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_UDEV_RULES=ON
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

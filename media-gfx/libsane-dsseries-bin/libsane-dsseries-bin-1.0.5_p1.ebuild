# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils udev

MY_PV="${PV/_p/-}"

DESCRIPTION="SANE driver for Brother DS-series scanners"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/index.html"
SRC_URI="http://download.brother.com/welcome/dlf100976/${PN/-bin}_${MY_PV}_amd64.deb"

RESTRICT="mirror"
QA_PREBUILT=".*"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-gfx/sane-backends"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	insinto /usr/lib64/sane
	insopts -m0755
	doins "usr/lib/tmp_DSDriver/x64/dsdrv_x64.so"
	doins "usr/lib/tmp_DSDriver/x64/NvUSBScan_x64.so"
	doins "usr/lib/tmp_DSDriver/x64/libsane-dsseries.so.1.0.17"
	dosym "libsane-dsseries.so.1.0.17" "usr/lib64/sane/libsane-dsseries.so.1"
	dosym "libsane-dsseries.so.1" "usr/lib64/sane/libsane-dsseries.so"

	insinto /etc/sane.d/dll.d
	insopts -m0644
	doins "${FILESDIR}/dsseries.conf"

	insinto /etc/sane.d
	doins "usr/lib/tmp_DSDriver/dsseries.conf"

	udev_dorules "${FILESDIR}/60-libsane-dsseries.rules"
}

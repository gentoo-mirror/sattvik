# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

MY_PV="${PV/_p/-}"

DESCRIPTION="LPR driver for Brother MFC-J6910DW printers"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/index.html"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/${PN/-bin/}-${MY_PV}.i386.deb"

RESTRICT="mirror"
QA_PREBUILT=".*"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	into /opt/brother
	dobin usr/bin/brprintconf_mfcj6910dw
	dosym \
		../../opt/brother/bin/brprintconf_mfcj6910dw \
		/usr/bin/brprintconf_mfcj6910dw
	rm -r usr || die

	cp -pPR opt/* "${ED}/opt/" || die
}

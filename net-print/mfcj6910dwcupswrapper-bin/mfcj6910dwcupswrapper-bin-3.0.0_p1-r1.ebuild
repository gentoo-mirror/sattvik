# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils

MY_PV="${PV/_p/-}"

DESCRIPTION="CUPS wrapper for the Brother MFC-J6910DW LPR drivers"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/index.html"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/${PN/-bin/}-${MY_PV}.i386.deb"

RESTRICT="mirror"
QA_PREBUILT=".*"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	net-print/cups
	net-print/cups-filters
	net-print/mfcj6910dwlpr-bin"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	epatch "${FILESDIR}/mfcj6910dwcupswrapper-3.0.0_p1-gentoo.patch"
	eapply_user
}

src_install() {
	cp -pPR opt "${ED}/opt/" || die
}

pkg_postinst() {
	einfo "Installing CUPS wrapper script..."
	/opt/brother/Printers/mfcj6910dw/cupswrapper/cupswrappermfcj6910dw
}

pkg_postrm() {
	einfo "Cleaning up live-installed files."
	local printer_model="mfcj6910dw"
	rm -f /usr/share/cups/model/Brother/brother_${printer_model}_printer_en.ppd
	rmdir --ignore-fail-on-non-empty /usr/share/cups/model/Brother
	rm -f /usr/share/ppd/Brother/brother_${printer_model}_printer_en.ppd
	rmdir --ignore-fail-on-non-empty /usr/share/ppd/Brother
	rm -f /usr/libexec/cups/filter/brother_lpdwrapper_${printer_model}
}

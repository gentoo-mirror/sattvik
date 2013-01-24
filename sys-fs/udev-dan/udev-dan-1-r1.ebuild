# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib

DESCRIPTION="Dan's udev additions"
HOMEPAGE="www.deepbluelambda.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-fs/udev-187-r1[keymap] <sys-fs/udev-197-r2[keymap]"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	insinto /usr/$(get_libdir)/udev/keymaps
	doins "${FILESDIR}"/thinkpad-dan

	insinto /usr/$(get_libdir)/udev/rules.d
	doins "${FILESDIR}"/95-keymap-thinkpad-dan.rules
}

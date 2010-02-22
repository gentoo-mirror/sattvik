# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/noscript/noscript-1.9.8.86.ebuild,v 1.3 2010/01/01 18:03:23 scarabeus Exp $

inherit mozextension multilib

MY_P="${P/-/_}"

DESCRIPTION="A vim-like interface for Firefox"
HOMEPAGE="http://vimperator.org/vimperator"
SRC_URI="http://vimperator-labs.googlecode.com/files/${MY_P}.xpi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
	|| (
		>=www-client/mozilla-firefox-3.5
		>=www-client/firefox-bin-3.5
		>=www-client/icecat-3.5
	)"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

# NOTES:
# can also be used for Flock, MidBrowser, eMusic, Toolkit, Songbird, Fennec

src_unpack() {
	xpi_unpack "${MY_P}".xpi
}

src_install() {
	local MOZILLA_FIVE_HOME
	mozillas=""

	if has_version '>=www-client/mozilla-firefox-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
		xpi_install "${WORKDIR}/${MY_P}"
		mozillas="$(best_version www-client/mozilla-firefox) ${mozillas}"
	fi
	if has_version '>=www-client/firefox-bin-3.5'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${WORKDIR}/${MY_P}"
		mozillas="$(best_version www-client/firefox-bin) ${mozillas}"
	fi
	if has_version '>=www-client/icecat-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/icecat"
		xpi_install "${WORKDIR}/${MY_P}"
		mozillas="$(best_version www-client/icecat) ${mozillas}"
	fi

}

pkg_postinst() {
	elog "NoScript has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "  $i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use noscript with them"
	elog "reinstall www-plugins/noscript"
}

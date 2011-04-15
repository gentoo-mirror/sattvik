# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/noscript/noscript-1.9.8.86.ebuild,v 1.3 2010/01/01 18:03:23 scarabeus Exp $

EAPI="2"

inherit mozextension multilib

MY_P="${P}-fx+sm"
DESCRIPTION="Adds a menu and a toolbar with various web developer tools."
HOMEPAGE="http://chrispederick.com/work/web-developer/"
SRC_URI="https://addons.mozilla.org/en-US/firefox/downloads/file/107252/${MY_P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="
	|| (
		>=www-client/firefox-1.5
		>=www-client/firefox-bin-1.5
		>=www-client/seamonkey-1.1
		>=www-client/seamonkey-bin-1.1
		>=www-client/icecat-3.5
	)"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

# NOTES:
# can also be used for Flock, MidBrowser, eMusic, Toolkit, Songbird, Fennec

src_unpack() {
	xpi_unpack "${MY_P}".xpi
}

src_prepare() {
	sed -i -r -e 's/(em:maxVersion>3\.)5\.\*/\16.*/' install.rdf
}

src_install() {
	local MOZILLA_FIVE_HOME
	mozillas=""

	if has_version '>=www-client/firefox-1.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
		xpi_install "${S}"
		mozillas="$(best_version www-client/firefox) ${mozillas}"
	fi
	if has_version '>=www-client/firefox-bin-1.5'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${S}"
		mozillas="$(best_version www-client/firefox-bin) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-1.1'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/seamonkey"
		xpi_install "${S}"
		mozillas="$(best_version www-client/seamonkey) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-bin-1.1'; then
		MOZILLA_FIVE_HOME="/opt/seamonkey"
		xpi_install "${S}"
		mozillas="$(best_version www-client/seamonkey-bin) ${mozillas}"
	fi
	if has_version '>=www-client/icecat-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/icecat"
		xpi_install "${S}"
		mozillas="$(best_version www-client/icecat) ${mozillas}"
	fi

}

pkg_postinst() {
	elog "Web Developer has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "  $i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use Web Developer"
	elog "with them reinstall www-plugins/web_developer"
}

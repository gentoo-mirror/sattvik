# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/noscript/noscript-1.9.8.86.ebuild,v 1.3 2010/01/01 18:03:23 scarabeus Exp $

inherit multilib

DESCRIPTION="Anonymous Google searches with Scroogle.org, SSL-encrypted"
HOMEPAGE="https://ssl.scroogle.org/"
SRC_URI="http://mycroft.mozdev.org/updateos.php/id0/scroogle_ssl.xml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
	|| (
		>=www-client/mozilla-firefox-1.5
		>=www-client/firefox-bin-1.5
		>=www-client/seamonkey-1.1
		>=www-client/seamonkey-bin-1.1
		>=www-client/icecat-3.5
	)"
DEPEND="${RDEPEND}"

S=${WORKDIR}

# NOTES:
# can also be used for Flock, MidBrowser, eMusic, Toolkit, Songbird, Fennec

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}"
}

search_install() {
	# You must tell search_install which xml to use
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument, please specify an xml to copy"

	x="${1}"
	cd ${x}
	insinto "${MOZILLA_FIVE_HOME}"/searchplugins/
	doins -r "${x}"/* || die "failed to copy extension"
}

src_install() {
	local MOZILLA_FIVE_HOME
	mozillas=""

	if has_version '>=www-client/mozilla-firefox-1.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
		search_install "${S}"
		mozillas="$(best_version www-client/mozilla-firefox) ${mozillas}"
	fi
	if has_version '>=www-client/firefox-bin-1.5'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		search_install "${S}"
		mozillas="$(best_version www-client/firefox-bin) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-1.1'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/seamonkey"
		search_install "${S}"
		mozillas="$(best_version www-client/seamonkey) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-bin-1.1'; then
		MOZILLA_FIVE_HOME="/opt/seamonkey"
		search_install "${S}"
		mozillas="$(best_version www-client/seamonkey-bin) ${mozillas}"
	fi
	if has_version '>=www-client/icecat-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/icecat"
		search_install "${S}"
		mozillas="$(best_version www-client/icecat) ${mozillas}"
	fi

}

pkg_postinst() {
	elog "Scroogle SSL search has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "  $i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use Scroogle SSL search"
	elog "with them reinstall www-plugins/scroogle-ssl"
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/noscript/noscript-1.9.8.86.ebuild,v 1.3 2010/01/01 18:03:23 scarabeus Exp $

EAPI="2"

inherit mozextension multilib versionator

DESCRIPTION="Web development plugin for Firefox"
HOMEPAGE="http://getfirebug.com/"
SRC_URI="http://getfirebug.com/releases/firebug/$(get_version_component_range 1-2)/${P/_beta/b}.xpi"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	|| (
		>=www-client/firefox-3.6
		>=www-client/firefox-bin-3.6
		>=www-client/seamonkey-1.1
		>=www-client/seamonkey-bin-1.1
		>=www-client/icecat-3.6
	)"
DEPEND="${RDEPEND}"

# NOTES:
# can also be used for Flock, MidBrowser, eMusic, Toolkit, Songbird, Fennec
S="${WORKDIR}/${P/_beta/b}"

src_unpack() {
	xpi_unpack "${P/_beta/b}".xpi
}

src_prepare() {
	chmod +x skin/classic content/firebug
}

firebug_install() {
	local emid="firebug@software.joehewitt.com"

	# You must tell xpi_install which xpi to use
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument, please specify an xpi to unpack"

	x="${1}"
	cd ${x}
	insinto "${MOZILLA_FIVE_HOME}"/extensions/${emid}
	doins -r "${x}"/* || die "failed to copy extension"
}

src_install() {
	local MOZILLA_FIVE_HOME
	mozillas=""

	if has_version '>=www-client/firefox-3.6'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
		firebug_install "${S}"
		mozillas="$(best_version www-client/firefox) ${mozillas}"
	fi
	if has_version '>=www-client/firefox-bin-3.6'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		firebug_install "${S}"
		mozillas="$(best_version www-client/firefox-bin) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-1.1'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/seamonkey"
		firebug_install "${S}"
		mozillas="$(best_version www-client/seamonkey) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-bin-1.1'; then
		MOZILLA_FIVE_HOME="/opt/seamonkey"
		firebug_install "${S}"
		mozillas="$(best_version www-client/seamonkey-bin) ${mozillas}"
	fi
	if has_version '>=www-client/icecat-3.6'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/icecat"
		firebug_install "${S}"
		mozillas="$(best_version www-client/icecat) ${mozillas}"
	fi

}

pkg_postinst() {
	elog "FireBug has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "  $i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use FireBug with them"
	elog "reinstall www-plugins/firebug"
}

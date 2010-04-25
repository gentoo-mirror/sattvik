# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/noscript/noscript-1.9.8.86.ebuild,v 1.3 2010/01/01 18:03:23 scarabeus Exp $

inherit mozextension multilib

MY_P="${P/-/_}"

DESCRIPTION="Make Firefox behave like Vim"
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

	cd "${S}"
	sed -i -r -e 's/(em:maxVersion>3\.)5\.\*/\16.*/' install.rdf

}

vimperator_install() {
	local emid="vimperator@mozdev.org"

	# You must tell xpi_install which xpi to use
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument, please specify an xpi to unpack"

	x="${1}"
	cd ${x}
	# determine id for extension
	insinto "${MOZILLA_FIVE_HOME}"/extensions/${emid}
	doins -r "${x}"/* || die "failed to copy extension"
}

src_install() {
	local MOZILLA_FIVE_HOME
	mozillas=""

	if has_version '>=www-client/mozilla-firefox-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
		vimperator_install "${WORKDIR}/${MY_P}"
		mozillas="$(best_version www-client/mozilla-firefox) ${mozillas}"
	fi
	if has_version '>=www-client/firefox-bin-3.5'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		vimperator_install "${WORKDIR}/${MY_P}"
		mozillas="$(best_version www-client/firefox-bin) ${mozillas}"
	fi
	if has_version '>=www-client/icecat-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/icecat"
		vimperator_install "${WORKDIR}/${MY_P}"
		mozillas="$(best_version www-client/icecat) ${mozillas}"
	fi

}

pkg_postinst() {
	elog "Vimperator has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "  $i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use Vimperator with them"
	elog "reinstall www-plugins/vimperator"
}

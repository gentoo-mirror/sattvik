# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Extra helper files for app-admin/logcheck"
HOMEPAGE="na"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="app-admin/logcheck"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
}

src_install() {
	insinto /usr/share/logtail/detectrotate
	doins "${FILESDIR}/40-logrotate-dateext-gzip.dtr"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac-git/trac-git-8215.ebuild,v 1.2 2010/07/05 11:00:44 hollow Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_PN="TracSubTicketsPlugin"
MY_P="TracSubTicketsPlugin-${PV}"
DESCRIPTION="Trac plug-in that offers sub-ticket feature for managing tickets."
HOMEPAGE="http://trac-hacks.org/wiki/SubticketsPlugin"
SRC_URI="http://trac-hacks.org/attachment/wiki/SubticketsPlugin/${MY_P}.zip?format=raw -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND=">=www-apps/trac-0.12
	dev-vcs/git"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-db_fix.patch"
}

src_install() {
	distutils_src_install
}

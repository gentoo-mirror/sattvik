# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Little git extras"
HOMEPAGE="https://github.com/tj/git-extras"
SRC_URI="https://github.com/tj/git-extras/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		sys-apps/util-linux"
BDEPEND="app-text/ronn"

src_compile() {
	emake docs
}

src_install() {
	emake install PREFIX="${ED}"/usr
}

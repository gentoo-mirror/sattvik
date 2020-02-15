# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

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
BDEPEND="virtual/awk"

src_compile() {
	:
}

src_install() {
	emake install PREFIX="${EPREIFX}"/usr SYSCONFDIR="${EPREFIX}"/etc DESTDIR="${D}"
	rm -rf "${D}"/etc/bash_completion.d

	newbashcomp etc/bash_completion.sh ${PN}

	insinto /usr/share/zsh/site-functions/contrib
	newins etc/git-extras-completion.zsh git-extras
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bash-completion-r1

MY_PN="todo.txt_cli"
MY_P="todo.txt_cli-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A simple and extensible shell script for managing your todo.txt file."
HOMEPAGE="http://todotxt.com"
SRC_URI="mirror://github/ginatrapani/todo.txt-cli/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion"

DEPEND=""
RDEPEND="${DEPEND}
		app-shells/bash"

src_install() {
	dobin todo.sh  || die
	dodoc todo.cfg || die

	use bash-completion && newbashcomp todo_completion todotxt
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/supertab/supertab-0.45.ebuild,v 1.1 2008/09/20 15:38:06 hawking Exp $

EAPI="2"

inherit vim-plugin

SCRIPT_ID=12388

DESCRIPTION="Lisp and Clojure REPL inside Vim with profiling and Hyperspec lookup, like SLIME "
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2531"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=${SCRIPT_ID} -> ${P}.zip"

LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"

src_unpack() {
	mkdir "${S}" || die "Could not create source unpack directory"
	cd "${S}" || die "Unable to change to unpack directory"
	unpack "${A}" || die "Unable to unpack source"
}

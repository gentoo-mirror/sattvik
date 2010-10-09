# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/colorschemes/colorschemes-20100218.ebuild,v 1.9 2010/05/23 19:11:05 pacho Exp $

EAPI="2"

inherit vim-plugin

DESCRIPTION="Sattvik's Vim colour scheme"
HOMEPAGE="http://www.vim.org/"
SRC_URI="https://www.intuitivelyobvious.net/distfiles/${P}.tar.bz2"

LICENSE="vim GPL-2 public-domain as-is"
KEYWORDS="amd64 x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a color scheme for vim. To switch to this color
schemes, use :colorscheme sattvik. To automatically set a scheme at
startup, please see :help vimrc ."

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dzen/dzen-0.8.5.ebuild,v 1.5 2009/09/30 04:45:48 jer Exp $

EAPI="2"

inherit subversion toolchain-funcs multilib

SLOT="2"
#MY_P="${PN}${SLOT}-${PV}"

DESCRIPTION="a general purpose messaging, notification and menuing program for
X11."
HOMEPAGE="http://gotmor.googlepages.com/dzen"
SRC_URI=""
ESVN_REPO_URI="http://dzen.googlecode.com/svn/trunk/"

LICENSE="MIT"
KEYWORDS=""
IUSE="minimal xft xinerama xpm"

RDEPEND="x11-libs/libX11
	xft? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )
	xpm? ( x11-libs/libXpm )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )"

#S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e "s:/usr/local:/usr:g" \
		-e 's:-Os::g' \
		-e "s:CFLAGS =:CFLAGS +=:g" \
		-e '/^CC.*/d' \
		-e 's:^LDFLAGS =:LDFLAGS +=:' \
		-e "s:/usr/lib :/usr/$(get_libdir) :" \
		-i config.mk gadgets/config.mk || die "sed failed"
	sed -i -e "/strip/d" Makefile gadgets/Makefile || die "sed failed"
	if ! use xft ; then
		sed -e '/^LIBS/s/ `pkg-config --libs xft`$//' \
		    -e '/^CFLAGS/s/ -DDZEN_XFT `pkg-config --cflags xft`$//' \
			-i config.mk || die "sed failed"
	fi
	if use xinerama ; then
		sed -e "/^LIBS/s/$/\ -lXinerama/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XINERAMA/" \
			-i config.mk || die "sed failed"
	fi
	if use xpm ; then
		sed -e "/^LIBS/s/$/\ -lXpm/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XPM/" \
			-i config.mk || die "sed failed"
	fi
}

src_compile() {
	tc-export CC
	emake || die "emake failed"

	if ! use minimal ; then
		cd "${S}"/gadgets
		emake || die "emake gadgets failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die

	if ! use minimal ; then
		cd "${S}"/gadgets
		emake DESTDIR="${D}" install || die "emake gadgets install failed"
		dodoc README* || die
	fi
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hplip/hplip-3.9.2.ebuild,v 1.3 2009/05/16 16:03:42 calchan Exp $

EAPI="2"

#inherit eutils fdo-mime linux-info python

DESCRIPTION="CUPS/Foomatic driver for Brother P-touch label printers"
HOMEPAGE="http://www.diku.dk/hjemmesider/ansatte/panic/P-touch/"
SRC_URI="http://www.diku.dk/hjemmesider/ansatte/panic/P-touch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

DEPEND="net-print/cups"

RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed."
}

src_install() {
#	CUPSFILTERDIR="$(cups-config --serverbin)/filter"
#	CUPSPPDDIR="$(cups-config --datadir)/model"

#	dodir "${CUPSFILTERDIR}"
#	dodir "${CUPSPPDDIR}"

	dobin rastertoptch
	emake DESTDIR="${D}" install || die "emake install failed"
}

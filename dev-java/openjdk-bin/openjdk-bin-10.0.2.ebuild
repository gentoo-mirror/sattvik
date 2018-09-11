# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils java-vm-2 prefix

DESCRIPTION="Java development kit, open source version"
HOMEPAGE="http://openjdk.java.net/"
SRC_URI="https://download.java.net/java/GA/jdk10/${PV}/19aef61b38124481863b1413dce1855f/13/openjdk-${PV}_linux-x64_bin.tar.gz"
LICENSE="GPL-2-with-classpath-exception"
SLOT="10"
KEYWORDS="~amd64"

DESTDIR="/opt/openjdk-bin-${SLOT}"
S="$WORKDIR/jdk-${PV}/"
IUSE="headless-awt alsa cups doc selinux +gentoo-vm source prefix"

COMMON_DEP=""

RDEPEND="!x64-macos? (
        !headless-awt? (
            x11-libs/libX11
            x11-libs/libXext
            x11-libs/libXi
            x11-libs/libXrender
            x11-libs/libXtst
        )
    )
    !prefix? ( dev-libs/elfutils
    sys-libs/glibc:*
	)
    alsa? ( media-libs/alsa-lib )
    cups? ( net-print/cups )
    doc? ( dev-java/java-sdk-docs:${SLOT} )
    media-libs/fontconfig:1.0
    selinux? ( sec-policy/selinux-java )"

src_install() {
    local dest="/opt/${PN}-${SLOT}"
	local ddest="${ED}${dest#/}"

	if ! use alsa ; then
        rm -vf "$S"/lib/libjsoundalsa.* || die
    fi
	
	if use headless-awt ; then
		rm -vf "$S"/lib/lib*{[jx]awt,splashscreen}* \
		   "$S"/bin/appletviewer || die
	fi
	
	if ! use source ; then
		rm -v "$S"/lib/src.zip || die
	fi
	
	dodir "$dest"
	cp -pPR "$S"/* "$ddest" || die

	use gentoo-vm && java-vm_install-env "${FILESDIR}"/${PN}-${SLOT}.env.sh
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}


pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	java-vm-2_pkg_postinst

	if use gentoo-vm ; then
		ewarn "WARNING! You have enabled the gentoo-vm USE flag, making this JDK"
		ewarn "recognised by the system. This will almost certainly break things."
	else
		ewarn "The experimental gentoo-vm USE flag has not been enabled so this JDK"
		ewarn "will not be recognised by the system. For example, simply calling"
		ewarn "\"java\" will launch a different JVM. This is necessary until Gentoo"
		ewarn "fully supports Java 10. This JDK must therefore be invoked using its"
		ewarn "absolute location under ${EPREFIX}/opt/${P}."
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
	java-vm-2_pkg_postrm
}


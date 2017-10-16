# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

MY_PN="${PN%-bin}"
MY_PNV="${MY_PN}-${PV}"
GITHUB_USER="boot-clj"

DESCRIPTION="Build tooling for Clojure"
HOMEPAGE="http://boot-clj.com/"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/releases/download/${PV}/${MY_PN}.sh -> ${MY_PNV}-boot.sh
		 https://raw.githubusercontent.com/${GITHUB_USER}/${MY_PN}/${PV}/README.md -> ${MY_PNV}-README.md
		 https://raw.githubusercontent.com/${GITHUB_USER}/${MY_PN}/${PV}/CHANGES.md -> ${MY_PNV}-CHANGES.md
"
LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jdk-1.7:*"
DEPEND=">=virtual/jdk-1.7:*"

RESTRICT="test"

src_unpack() {
	mkdir -p "${S}" || die "Can't mkdir ${S}"
	cd "${S}"	|| die "Can't enter ${S}"
	for file in ${A}; do
		einfo "Copying ${file}"
		cp "${DISTDIR}/${file}" "${S}/" || die "Can't copy ${file}"
	done
}

src_compile() { :; }

src_install() {
	newbin "${S}/${MY_PNV}-boot.sh" boot
	for file in "README.md" "CHANGES.md"; do
		newdoc "${S}/${MY_PNV}-$file" "$file"
	done
}

pkg_postinst() {
	einfo "This package will still download a whole lot of its own runtime"
	einfo "dependencies the first time you run it."
	einfo ""
	einfo "This currently can't be helped and is expected behaviour for a"
	einfo "java based development toolkit"
}

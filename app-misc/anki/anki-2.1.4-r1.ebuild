# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )
PYTHON_REQ_USE="sqlite"

inherit eutils python-single-r1 xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net"

SRC_URI="https://apps.ankiweb.net/downloads/current/${P}-source.tgz -> ${P}.tgz"
S="${WORKDIR}/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex +recording +sound test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/PyQt5[gui,svg,webengine,widgets,${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.7.4[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/pyaudio[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	recording? ( media-sound/lame )
	sound? ( media-video/mpv )
	latex? (
		app-text/texlive
		app-text/dvipng
	)
	!dev-qt/assistant:5/5.11
	!dev-qt/designer:5/5.11
	!dev-qt/linguist:5/5.11
	!dev-qt/linguist-tools:5/5.11
	!dev-qt/pixeltool:5/5.11
	!dev-qt/qdbus:5/5.11
	!dev-qt/qdbusviewer:5/5.11
	!dev-qt/qdoc:5/5.11
	!dev-qt/qt3d:5/5.11
	!dev-qt/qtbluetooth:5/5.11
	!dev-qt/qtcharts:5/5.11
	!dev-qt/qtconcurrent:5/5.11
	!dev-qt/qtcore:5/5.11
	!dev-qt/qtdatavis3d:5/5.11
	!dev-qt/qtdbus:5/5.11
	!dev-qt/qtdeclarative:5/5.11
	!dev-qt/qtdiag:5/5.11
	!dev-qt/qtgraphicaleffects:5/5.11
	!dev-qt/qtgui:5/5.11
	!dev-qt/qthelp:5/5.11
	!dev-qt/qtimageformats:5/5.11
	!dev-qt/qtlocation:5/5.11
	!dev-qt/qtmultimedia:5/5.11
	!dev-qt/qtnetwork:5/5.11
	!dev-qt/qtnetworkauth:5/5.11
	!dev-qt/qtopengl:5/5.11
	!dev-qt/qtpaths:5/5.11
	!dev-qt/qtplugininfo:5/5.11
	!dev-qt/qtpositioning:5/5.11
	!dev-qt/qtprintsupport:5/5.11
	!dev-qt/qtquickcontrols:5/5.11
	!dev-qt/qtquickcontrols2:5/5.11
	!dev-qt/qtscript:5/5.11
	!dev-qt/qtscxml:5/5.11
	!dev-qt/qtsensors:5/5.11
	!dev-qt/qtserialbus:5/5.11
	!dev-qt/qtserialport:5/5.11
	!dev-qt/qtspeech:5/5.11
	!dev-qt/qtsql:5/5.11
	!dev-qt/qtsvg:5/5.11
	!dev-qt/qttest:5/5.11
	!dev-qt/qttranslations:5/5.11
	!dev-qt/qtvirtualkeyboard:5/5.11
	!dev-qt/qtwayland:5/5.11
	!dev-qt/qtwebchannel:5/5.11
	!dev-qt/qtwebengine:5/5.11
	!dev-qt/qtwebsockets:5/5.11
	!dev-qt/qtwebview:5/5.11
	!dev-qt/qtwidgets:5/5.11
	!dev-qt/qtx11extras:5/5.11
	!dev-qt/qtxml:5/5.11
	!dev-qt/qtxmlpatterns:5/5.11
"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

PATCHES=( "${FILESDIR}"/${PN}-2.1.0_beta25-web-folder.patch )

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i -e "s/updates=True/updates=False/" \
		aqt/profiles.py || die
}

src_compile() {
	:;
}

src_test() {
	sed -e "s:nosetests:${EPYTHON} ${EROOT}usr/bin/nosetests:" \
		-i tools/tests.sh || die
	./tools/tests.sh || die
}

src_install() {
	doicon ${PN}.png
	domenu ${PN}.desktop
	doman ${PN}.1

	dodoc README.md README.development
	python_domodule aqt anki
	python_newscript runanki anki

	# Localization files go into the anki directory:
	python_moduleinto anki
	python_domodule locale

	# not sure if this is correct, but
	# site-packages/aqt/mediasrv.py wants the directory
	insinto /usr/share/anki
	doins -r web
}

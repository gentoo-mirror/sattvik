# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9,10,11} )
inherit distutils-r1

DESCRIPTION="Python library to control the Elgato Stream Deck"
HOMEPAGE="https://github.com/abcminiuser/python-elgato-streamdeck"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/abcminiuser/python-elgato-streamdeck.git"
else
	SRC_URI="https://github.com/abcminiuser/python-elgato-streamdeck/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/python-${P}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-python/pillow-9.0.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

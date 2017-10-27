# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{4,5,6} )
PYTHON_REQ_USE="sqlite"

inherit bash-completion-r1 distutils-r1 git-r3

DESCRIPTION="A simple CalDav-based todo manager"
HOMEPAGE="https://github.com/pimutils/todoman"
EGIT_REPO_URI="https://github.com/pimutils/todoman"

LICENSE="ISC"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="bash-completion test"

RDEPEND="dev-python/atomicwrites[${PYTHON_USEDEP}]
	>=dev-python/click-6.0[${PYTHON_USEDEP}]
	>=dev-python/click-log-0.2.1[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/humanize[${PYTHON_USEDEP}]
	dev-python/icalendar[${PYTHON_USEDEP}]
	dev-python/parsedatetime[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/urwid[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst todoman.conf.sample )

python_test() {
	pytest || die "Tests fail with ${EPYTHON}"
}

src_install() {
	default

	dobin bin/todo

	if use bash-completion; then
		dobashcomp contrib/completion/bash/_todo
	fi
}

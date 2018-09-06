# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/awslabs/${PN}

EGIT_COMMIT="v${PV}"
SRC_URI="https://github.com/awslabs/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

# inherit golang-build golang-vcs-snapshot
inherit golang-base golang-vcs-snapshot

DESCRIPTION="Automatically gets credentials for Amazon ECR on docker push/docker pull"
HOMEPAGE="https://github.com/awslabs/amazon-ecr-credential-helper"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego_pn_check
	set -- env GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go build -v -work -x ${EGO_BUILD_FLAGS} ${EGO_PN}/ecr-login/cli/docker-credential-ecr-login
	echo "$@"
	"$@" || die
}

src_install() {
	cd ${EGO_PN}
	dobin docker-credential-ecr-login
}

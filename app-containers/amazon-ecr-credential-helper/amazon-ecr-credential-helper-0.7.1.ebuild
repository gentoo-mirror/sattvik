# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
EGO_PN=github.com/awslabs/${PN}

inherit go-module

EGO_VER="v${PV}"
SRC_URI="https://github.com/awslabs/${PN}/archive/${EGO_VER}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="Automatically gets credentials for Amazon ECR on docker push/docker pull"
HOMEPAGE="https://github.com/awslabs/amazon-ecr-credential-helper"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${P}/ecr-login/cli/docker-credential-ecr-login"

src_compile() {
	ego build
}

src_install() {
	dobin docker-credential-ecr-login

	default
}

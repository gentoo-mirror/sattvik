# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
EGO_PN=github.com/awslabs/${PN}

inherit go-module

SRC_URI="https://${PN}-releases.s3.us-east-2.amazonaws.com/${PV}/release.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${P}-deps.tar.xz"

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
	cd "${WORKDIR}/${P}/docs"
	doman docker-credential-ecr-login.1

	default
}

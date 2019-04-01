#!/bin/bash

set -oue pipefail

builder_context=master
tag=${COMMIT_SHA:-}
branch=$({git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
case "$branch" in
		"master") builder_context=master
							;;
		*)        builder_context=pr
							tag=pr
							;;
esac

cat <<EOF
DOCKER_REGISTRY ${AWS_ACCOUNT_ID:-}.dkr.ecr.${AWS_PRIMARY_REGION:-us-west-2}.amazonaws.com
GIT_BRANCH ${GIT_BRANCH:-${branch}}
BUILDER_CONTEXT ${BUILDER_CONTEXT:-${builder_context}}
TAG ${tag:-}
EOF

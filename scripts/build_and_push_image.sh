#! /usr/bin/env nix-shell
#! nix-shell ../shell.nix -i bash

set -eu

OCI_ARCHIVE=$(nix-build --no-out-link -A packages.x86_64-linux.ociApplicationImage)
DOCKER_REPOSITORY="docker://seanrmurphy/nix-container-build-gha"
DOCKER_USERNAME="seanrmurphy"

if [ -z ${DOCKER_ACCESS_TOKEN+x} ]; then
	skopeo --insecure-policy copy "docker-archive:${OCI_ARCHIVE}" "$DOCKER_REPOSITORY"
else
	skopeo --insecure-policy copy --dest-creds="$DOCKER_USERNAME:$DOCKER_ACCESS_TOKEN" "docker-archive:${OCI_ARCHIVE}" "$DOCKER_REPOSITORY"
fi

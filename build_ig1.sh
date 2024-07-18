#!/usr/bin/env bash

set -e

if [ -z "$IG1_GHCR_DIFY_TOKEN" ]; then
	echo "Please set your IG1_GHCR_DIFY_TOKEN env var" >&2
	exit 1
fi

echo "Logging in"
CR_PAT=$IG1_GHCR_DIFY_TOKEN
echo $CR_PAT | docker login ghcr.io -u hekmon --password-stdin
echo
version=$(git describe --tags --abbrev=0)
image="ghcr.io/iguanesolutions/dify:$version"
echo "Handling $image"
echo
cd api
echo "building"
docker build -t "$image" .
echo
echo "publishing"
docker push "$image"
cd -

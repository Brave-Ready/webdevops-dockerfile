#!/bin/bash

REGION="us-central1"
PROJECT_ID="onward-ops"
REPOSITORY="onward-ops"
IMAGE="webdevops-php-nginx"
TAG="8.1"

FULL_IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE}:${TAG}"

set -x
time DOCKER_BUILDKIT=0 docker build -t ${FULL_IMAGE} --build-arg BUILDKIT_INLINE_CACHE=1 . | tee docker.log

gcloud auth print-access-token | docker login \
  -u oauth2accesstoken \
  --password-stdin https://${REGION}-docker.pkg.dev

docker push $FULL_IMAGE

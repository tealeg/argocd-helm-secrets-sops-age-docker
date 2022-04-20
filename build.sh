#!/bin/bash

ARGOCD_VERSION="2.3.3"
SOPS_VERSION="3.7.2"
HELM_SECRETS_VERSION="3.13.0"

STEP=2


IMAGE_REPOSITORY=tealeg/argocd-helm-secrets-sops-age
IMAGE_TAG="v${ARGOCD_VERSION}-v${HELM_SECRETS_VERSION}-v${SOPS_VERSION}-plus-age-${STEP}"

# docker build -f Dockerfile -t "${IMAGE_REPOSITORY}:${IMAGE_TAG}" --build-arg ARGOCD_VERSION="${ARGOCD_VERSION}" --build-arg SOPS_VERSION="${SOPS_VERSION}" --build-arg HELM_SECRETS_VERSION="${HELM_SECRETS_VERSION}" .

# docker tag "${IMAGE_REPOSITORY}:${IMAGE_TAG}" "${IMAGE_REPOSITORY}:latest"

docker push "${IMAGE_REPOSITORY}:${IMAGE_TAG}"
docker push "${IMAGE_REPOSITORY}:latest"


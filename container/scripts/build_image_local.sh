#!/usr/bin/env bash
set -euo pipefail
IMAGE_NAME="${1:-qrg-h200-cuda:latest}"
DOCKERFILE="${DOCKERFILE:-Dockerfile}"
BASE_IMAGE="${CUDA_IMAGE:-nvidia/cuda:12.6.3-devel-ubuntu22.04}"
docker build --build-arg CUDA_IMAGE="$BASE_IMAGE" -f "$DOCKERFILE" -t "$IMAGE_NAME" .
echo "Built $IMAGE_NAME"

#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 LOCAL_IMAGE REGISTRY_IMAGE" >&2
  echo "Example: $0 qrg-h200-cuda:latest ghcr.io/YOURNAME/qrg-h200-cuda:latest" >&2
  exit 2
fi
LOCAL="$1"
REMOTE="$2"
docker tag "$LOCAL" "$REMOTE"
docker push "$REMOTE"
echo "Pushed $REMOTE"

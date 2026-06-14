#!/usr/bin/env bash
set -euo pipefail

echo "[QRG container] starting at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "[QRG container] user=$(id -u):$(id -g) cwd=$(pwd)"
mkdir -p "${QRG_PERSISTENT_DIR:-/workspace/qrg_persistent}" "${QRG_SCRATCH_DIR:-/workspace/qrg_scratch}" /workspace/uploads || true

if command -v nvidia-smi >/dev/null 2>&1; then
  echo "[QRG container] nvidia-smi:"
  nvidia-smi || true
else
  echo "[QRG container] WARNING: nvidia-smi not found. This image needs to run with NVIDIA GPU runtime on a CUDA host."
fi

if [[ "${QRG_START_SSH:-0}" == "1" ]]; then
  echo "[QRG container] starting sshd"
  service ssh start || /usr/sbin/sshd || true
fi

if [[ "${QRG_START_JUPYTER:-0}" == "1" ]]; then
  echo "[QRG container] starting JupyterLab on :8888"
  nohup jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root \
    --ServerApp.token="${JUPYTER_TOKEN:-qrg}" \
    --ServerApp.password="" \
    > /workspace/jupyter.log 2>&1 &
fi

if [[ $# -gt 0 ]]; then
  echo "[QRG container] executing: $*"
  exec "$@"
fi

exec sleep infinity

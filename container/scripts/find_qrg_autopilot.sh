#!/usr/bin/env bash
set -euo pipefail

candidates=(
  "/workspace/QRG_H200_Cloud_Autopilot_Package.zip"
  "/workspace/uploads/QRG_H200_Cloud_Autopilot_Package.zip"
  "/workspace/qrg_persistent/QRG_H200_Cloud_Autopilot_Package.zip"
  "/opt/qrg/payload/QRG_H200_Cloud_Autopilot_Package.zip"
)
for p in "${candidates[@]}"; do
  if [[ -f "$p" ]]; then
    echo "$p"
    exit 0
  fi
done
found=$(find /workspace /opt/qrg/payload -maxdepth 4 -type f -name 'QRG_H200_Cloud_Autopilot_Package.zip' 2>/dev/null | head -n 1 || true)
if [[ -n "$found" ]]; then
  echo "$found"
  exit 0
fi

echo "ERROR: Could not find QRG_H200_Cloud_Autopilot_Package.zip." >&2
echo "Upload it to /workspace or build with Dockerfile.with_payload." >&2
exit 2

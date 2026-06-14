#!/usr/bin/env bash
set -Eeuo pipefail
STAGE="${1:-gpu0a_gated}"
PERSISTENT_DIR="${QRG_PERSISTENT_DIR:-/workspace/qrg_persistent}"
SCRATCH_DIR="${QRG_SCRATCH_DIR:-/workspace/qrg_scratch}"
mkdir -p "$PERSISTENT_DIR" "$SCRATCH_DIR" /workspace

echo "QRG RunPod gated container runner"
echo "stage=$STAGE"
echo "persistent=$PERSISTENT_DIR"
echo "scratch=$SCRATCH_DIR"

AUTOPILOT_ZIP=""
for p in \
  /workspace/QRG_H200_Gated_Autopilot_v2.zip \
  /opt/qrg/payload/QRG_H200_Gated_Autopilot_v2.zip \
  /workspace/QRG_H200_Cloud_Autopilot_Package.zip \
  /opt/qrg/payload/QRG_H200_Cloud_Autopilot_Package.zip \
  ; do
  if [[ -f "$p" ]]; then AUTOPILOT_ZIP="$p"; break; fi
done

if [[ -z "$AUTOPILOT_ZIP" ]]; then
  echo "Could not find QRG_H200_Gated_Autopilot_v2.zip. Upload it to /workspace or bake it into /opt/qrg/payload."
  exit 2
fi

echo "Using autopilot: $AUTOPILOT_ZIP"
WORK=/workspace/qrg_autopilot_work
rm -rf "$WORK" && mkdir -p "$WORK"
unzip -oq "$AUTOPILOT_ZIP" -d "$WORK"
cd "$WORK"/qrg_h200_gated_autopilot
chmod +x run_qrg_h200_gated_autopilot.sh
./run_qrg_h200_gated_autopilot.sh --stage "$STAGE" --persistent-dir "$PERSISTENT_DIR" --scratch-dir "$SCRATCH_DIR"

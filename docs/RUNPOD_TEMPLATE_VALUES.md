# Suggested RunPod Template Values

```text
Image:
  ghcr.io/YOURNAME/qrg-h200-cuda:latest

GPU:
  1× H200 preferred
  1× H100 acceptable

Container Disk:
  40GB minimum
  80GB recommended

Volume:
  500GB recommended
  mount path: /workspace

Environment:
  QRG_PERSISTENT_DIR=/workspace/qrg_persistent
  QRG_SCRATCH_DIR=/workspace/qrg_scratch
  QRG_START_JUPYTER=0
  QRG_START_SSH=0

Ports:
  8888/http optional if Jupyter enabled
  22/tcp optional if SSH enabled

Start command:
  leave default, or use:
  sleep infinity
```

First commands:

```bash
/opt/qrg/bin/check_container_env.sh
/opt/qrg/bin/run_qrg_autopilot_from_container.sh validate_only
/opt/qrg/bin/run_qrg_autopilot_from_container.sh gpu0a
```

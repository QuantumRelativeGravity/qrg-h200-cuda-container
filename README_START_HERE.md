# QRG RunPod H200 CUDA Container — Public-Safe Repo Package

This repository builds the **dependency container only**. It does **not** include the QRG payload archive or model source bundles.

Use this when the GitHub repository or GHCR image may be public. After deploying the container on RunPod, upload `QRG_H200_Gated_Autopilot_v2.zip` separately into `/workspace`.

## Build path

1. Create a new GitHub repository.
2. Upload the contents of this folder to the repository root.
3. Go to **Actions** and run **Build QRG RunPod CUDA Container**.
4. The workflow publishes a container image to GitHub Container Registry, usually:

```text
ghcr.io/<your-github-username>/<repo-name>:latest
```

5. In RunPod, create a custom template using that image.
6. Mount persistent storage at `/workspace`.
7. Start the pod, upload `QRG_H200_Gated_Autopilot_v2.zip` to `/workspace`, then run:

```bash
/opt/qrg/bin/check_container_env.sh
/opt/qrg/bin/run_qrg_autopilot_from_container.sh validate_only
/opt/qrg/bin/run_qrg_autopilot_from_container.sh gpu0a_gated
```

## Why this package does not include the QRG payload

A public container image can expose files baked into it. Keep the project archive private by uploading the payload only to the paid RunPod instance.

## Required payload

Upload this file to `/workspace` inside the pod:

```text
QRG_H200_Gated_Autopilot_v2.zip
```

## Safety block

The container is intended for GPU parity only. It should not enable C2.16, SPTZ, LCBA, bridge/wormhole analogs, wake/propulsion candidates, warp shells, or remote rebinding.

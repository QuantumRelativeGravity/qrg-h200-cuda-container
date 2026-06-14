# RunPod Custom Image Deployment Guide for QRG

## 1. Build the image

### Option A: GitHub Container Registry, no local Docker required

1. Create a new GitHub repository, for example `qrg-h200-cuda-container`.
2. Upload the contents of this package.
3. Go to **Actions**.
4. Run `Build QRG RunPod CUDA Container` manually.
5. The image will publish as:

```text
ghcr.io/<your-github-username>/qrg-h200-cuda:latest
```

If the package is private, make sure RunPod can pull it. The easiest first test is making the package image public.

### Option B: Build locally with Docker

```bash
./container/scripts/build_image_local.sh qrg-h200-cuda:latest
./container/scripts/push_image.sh qrg-h200-cuda:latest docker.io/YOURNAME/qrg-h200-cuda:latest
```

For local builds on Windows, Docker Desktop must be running. You do not need a local NVIDIA GPU just to build the image, but the image will only run CUDA on a GPU host.

## 2. Create a RunPod template

In RunPod:

1. Create a custom template.
2. Image name: `ghcr.io/YOURNAME/qrg-h200-cuda:latest` or `docker.io/YOURNAME/qrg-h200-cuda:latest`.
3. Container disk: 40GB minimum; 80GB recommended.
4. Attach a network/persistent volume mounted to `/workspace`.
5. Recommended volume size: 500GB.
6. Choose H200 if available.
7. Start the pod.

## 3. Run validation

Open a terminal in the pod:

```bash
/opt/qrg/bin/check_container_env.sh
```

Then upload or place `QRG_H200_Cloud_Autopilot_Package.zip` in `/workspace`.

Run:

```bash
/opt/qrg/bin/run_qrg_autopilot_from_container.sh validate_only
```

If clean:

```bash
/opt/qrg/bin/run_qrg_autopilot_from_container.sh gpu0a
```

## 4. Collect outputs

The autopilot writes result bundles under:

```text
/workspace/qrg_persistent
```

Download the latest `.tar.zst`, `.zip`, or result folder and send it back for analysis.

## 5. Stop the pod

Stop the GPU instance as soon as the result bundle is downloaded or safely stored. Persistent volume charges can remain if you keep the volume.

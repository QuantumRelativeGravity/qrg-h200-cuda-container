# QRG RunPod CUDA container (dependencies + helper scripts; payload uploaded to /workspace)
# Default base chosen for broad H100/H200 compatibility; override with --build-arg CUDA_IMAGE=...
ARG CUDA_IMAGE=nvidia/cuda:12.6.3-devel-ubuntu22.04
FROM ${CUDA_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    QRG_HOME=/opt/qrg \
    QRG_WORKSPACE=/workspace \
    QRG_PERSISTENT_DIR=/workspace/qrg_persistent \
    QRG_SCRATCH_DIR=/workspace/qrg_scratch

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash ca-certificates curl wget git unzip zip zstd xz-utils tar gzip \
    build-essential cmake ninja-build pkg-config \
    python3 python3-pip python3-venv python3-dev \
    jq htop nano vim less time rsync \
    openssh-server nginx supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install pytest pyyaml numpy scipy pandas matplotlib rich tqdm zstandard jupyterlab

# Configure SSH/Jupyter directories. Services are optional and controlled by env vars.
RUN mkdir -p /var/run/sshd /workspace /opt/qrg/bin /opt/qrg/docs /opt/qrg/payload && \
    chmod 0777 /workspace

COPY container/scripts/ /opt/qrg/bin/
COPY docs/ /opt/qrg/docs/
RUN chmod +x /opt/qrg/bin/*.sh

WORKDIR /workspace
EXPOSE 22 8888
ENTRYPOINT ["/opt/qrg/bin/entrypoint.sh"]
CMD ["sleep", "infinity"]

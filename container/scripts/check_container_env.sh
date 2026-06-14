#!/usr/bin/env bash
set -euo pipefail

echo "=== QRG container environment check ==="
date -u +%Y-%m-%dT%H:%M:%SZ
uname -a || true
cat /etc/os-release || true

echo "--- GPU ---"
if command -v nvidia-smi >/dev/null 2>&1; then nvidia-smi; else echo "nvidia-smi: MISSING"; fi
if command -v nvcc >/dev/null 2>&1; then nvcc --version; else echo "nvcc: MISSING"; fi

echo "--- Toolchain ---"
python3 --version
g++ --version | head -n 1 || true
cmake --version | head -n 1 || true
ninja --version || true

echo "--- Python packages ---"
python3 - <<'PY'
import importlib
for name in ["numpy","scipy","pandas","pytest","yaml","zstandard"]:
    try:
        m = importlib.import_module(name)
        print(f"{name}: {getattr(m, '__version__', 'present')}")
    except Exception as e:
        print(f"{name}: MISSING ({e})")
PY

echo "--- Storage ---"
df -h /workspace || df -h

echo "=== OK ==="

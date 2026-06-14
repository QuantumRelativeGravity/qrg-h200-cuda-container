# QRG Container Design Notes

This image is intentionally a **dependency/runtime container**, not the physics source of truth.

The source of truth remains:

- `QRG_C2_15Z_R_FULL_ARCHIVAL_BUNDLE.zip`
- `qrg_c215wk_weak_history_main_kernel_observability_release_bundle.zip`
- `QRG_H200_Cloud_Autopilot_Package.zip`

The container provides:

- CUDA development base image
- compiler toolchain
- Python packages
- CMake/Ninja
- zstd/zip/jq utilities
- helper scripts
- optional SSH/Jupyter support

The container must not enable C2.16 or any exotic candidate by default.

## Trace modes

The weak-history observability plane should be treated as an observability layer:

- `trace_off`: strict baseline parity
- `trace_full`: 100k/500k/1M trace-on parity
- `trace_sampled`: 3M/10M stress if memory is tight

Trace data must not feed event selection, capacity gates, action/entropy selector, reconstruction, or C2.16.

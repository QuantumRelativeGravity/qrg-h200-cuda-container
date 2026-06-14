#!/usr/bin/env bash
set -euo pipefail
/opt/qrg/bin/check_container_env.sh
/opt/qrg/bin/run_qrg_autopilot_from_container.sh validate_only

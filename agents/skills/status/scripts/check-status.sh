#!/usr/bin/env bash
# Railway status check - sources common lib and runs preflight

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/railway-common.sh"

railway_preflight

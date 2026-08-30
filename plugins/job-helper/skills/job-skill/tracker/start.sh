#!/bin/sh
# Launch the job application tracker UI (opens your browser).
exec python3 "$(dirname "$0")/server.py" "$@"

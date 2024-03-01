#!/bin/bash

# Example usage:
#   log -l INFO "This is an informational message"
#   log -l ERROR "This is an error message"
#   log -l DEBUG "This is a debug message"
#   log "This is another informational message"  # This will log an informational message with default level "INFO"

log() {
    local level="INFO" # default logging level
    local message=""

    # Parse flags
    while [[ $# -gt 0 ]]; do
        if [[ "$1" == -* ]]; then
            case "$1" in
                -l|--level)
                    level="$2"
                    shift 2
                    ;;
                *)
                    echo "Unknown option: $1" >&2
                    exit 1
                    ;;
            esac
        else
            message="$1"
            shift
        fi
    done

    # Log format: [timestamp] [script_name] [log_level] message
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$(basename "$0")] [$level] $message"
}
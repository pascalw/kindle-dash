DIR="$(dirname $0)"
ENV_FILE="$DIR/local/env.sh"
LOG_FILE="$DIR/logs/dash.log"

mkdir -p $(dirname "$LOG_FILE")
[ -f "$ENV_FILE" ] && source "$ENV_FILE"

"$DIR/dash.sh" >> "$LOG_FILE" 2>&1 &

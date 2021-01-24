DIR="$(dirname $0)"
ENV_FILE="$DIR/local/env.sh"
LOGS="$DIR/logs/dash.log"

[ -f "$ENV_FILE" ] && source "$ENV_FILE"
"$DIR/dash.sh" >> "$LOGS" 2>&1 &

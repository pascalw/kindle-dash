DIR="$(dirname $0)"
DASH_PNG="$DIR/dash.png"
FETCH_DASHBOARD_CMD="$DIR/local/fetch-dashboard.sh"

echo "Refreshing dashboard"
"$DIR/wait-for-wifi.sh"

"$FETCH_DASHBOARD_CMD" "$DASH_PNG" $1

echo "Full screen refresh"
/usr/sbin/eips -f -g "$DASH_PNG"

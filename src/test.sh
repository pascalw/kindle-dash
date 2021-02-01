DIR="$(dirname $0)"
DASH_PNG="$DIR/dash.png"

echo "Refreshing dashboard"
"$DIR/wait-for-wifi.sh"

$(dirname $0)/ht -d -q -o "$DASH_PNG" get $1

echo "Full screen refresh"
/usr/sbin/eips -f -g "$DASH_PNG"

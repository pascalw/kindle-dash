#!/usr/bin/env sh
# Fetch a new dashboard image, make sure to output it to "$1".
# For example:
# "$(dirname "$0")/../xh" -d -q -o "$1" get https://raw.githubusercontent.com/pascalw/kindle-dash/master/example/example.png
cat /mnt/us/documents/dashboard.png > "$1"

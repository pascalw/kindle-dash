#!/usr/bin/env sh
# Fetch a new dashboard image, make sure to output it to "$1".
# For example:
$(dirname $0)/ht -d -q -o "$1" get https://example.org/example.png

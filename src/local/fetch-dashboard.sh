#!/usr/bin/env sh
# Fetch a new dashboard image, make sure to output it to "$1".
# For example:
$(dirname $0)/../ht -d -q -o "$1" get ${2:-"https://raw.githubusercontent.com/pascalw/kindle-dash/master/example/example.png"}

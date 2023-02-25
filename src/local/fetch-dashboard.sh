#!/usr/bin/env sh

# Url of content to download
CONTENT="https://raw.githubusercontent.com/pascalw/kindle-dash/master/example/example.png"

# Fetch a new dashboard image, make sure to output it to "$1".
# For example:
"$(dirname "$0")/../xh" -d -q -o "$1" get $CONTENT
# xh seems not to be able to load certificates on Kindle PW Touch: fall back to curl in case of error
if [ $? != 0 ]; then
  curl -o "$1" "$CONTENT"
fi
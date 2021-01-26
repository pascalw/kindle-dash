# Kindle dashboard

1. Download the [latest release](https://github.com/pascalw/kindle-dash/releases) on your computer and extract it.
2. Modify `dist/local/fetch-dashboard.sh`and optionally `dist/local/env.sh`.
3. Copy `dist/` to Kindle, for example: `rsync -vr ./dist kindle:/mnt/us/dashboard`.
4. Start dashboard with `/mnt/us/dashboard/start.sh`.

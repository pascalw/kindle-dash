source ../src/logging.sh

REFRESH_SCHEDULE=${REFRESH_SCHEDULE:-"2,32 8-17 * * MON-FRI"}

log "Starting dashboard with $REFRESH_SCHEDULE refresh..."
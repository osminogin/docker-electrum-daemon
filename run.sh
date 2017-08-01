#!/usr/bin/env bash
set -x

# graceful shutdown
trap 'echo 123123; pkill -TERM -P1; electrum daemon stop; exit 0' SIGTERM

# run application
electrum daemon start && socat -v TCP-LISTEN:7000,fork TCP:127.0.0.1:7777

# wait forever
while true; do
  tail -f /dev/null & wait ${!}
done

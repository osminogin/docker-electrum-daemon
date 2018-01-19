#!/usr/bin/env bash
set -x

# graceful shutdown
trap 'pkill -TERM -P1; electrum daemon stop; exit 0' SIGTERM

# Set config
electrum setconfig rpcuser ${ELECTRUM_USER}
electrum setconfig rpcpassword ${ELECTRUM_PASSWORD}
electrum setconfig rpcport 7777

# run application
electrum daemon start && socat -v TCP-LISTEN:7000,fork TCP:127.0.0.1:7777

# wait forever
while true; do
  tail -f /dev/null & wait ${!}
done

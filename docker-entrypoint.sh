#!/usr/bin/env sh
set -ex

# Network switch
if [ "$TESTNET" = true ] || [ "$ELECTRUM_NETWORK" = "testnet" ]; then
  FLAGS='--testnet'
elif [ "$ELECTRUM_NETWORK" = "regtest" ]; then
  FLAGS='--regtest'
elif [ "$ELECTRUM_NETWORK" = "simnet" ]; then
  FLAGS='--simnet'
fi


# Graceful shutdown
trap 'pkill -TERM -P1; electrum daemon stop; exit 0' SIGTERM

# Set config
electrum $FLAGS setconfig rpcuser ${ELECTRUM_USER}
electrum $FLAGS setconfig rpcpassword ${ELECTRUM_PASSWORD}
electrum $FLAGS setconfig rpchost 0.0.0.0
electrum $FLAGS setconfig rpcport 7000

# XXX: Check load wallet or create

# Run application
electrum $FLAGS daemon start

# Wait forever
while true; do
  tail -f /dev/null & wait ${!}
done

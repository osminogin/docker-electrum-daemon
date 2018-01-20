#!/usr/bin/env sh
set -ex

# Graceful shutdown
trap 'pkill -TERM -P1; electrum daemon stop; exit 0' SIGTERM

# Set config
electrum setconfig rpcuser ${ELECTRUM_USER}
electrum setconfig rpcpassword ${ELECTRUM_PASSWORD}
electrum setconfig rpchost 0.0.0.0
electrum setconfig rpcport 7000

# XXX: Check load wallet or create

# Run application
electrum daemon start

echo "checking status"
electrum daemon status
echo "Done"

# Restore from keys if available
if [ -n "$ELECTRUM_MASTER_PRIVATE_KEY" ];
then
  echo "Restoring and loading wallet from Master Private Key"
  {
    # && - do not stop script if command fails
    echo | electrum restore $ELECTRUM_MASTER_PRIVATE_KEY
  } || { # catch
    echo "Wallet already exists; skipping..."
  }
  electrum daemon load_wallet
elif [ -n "$ELECTRUM_MASTER_PUBLIC_KEY" ];
then
  echo "Restoring and loading wallet from Master Public Key"
  {
    # && - do not stop script if command fails
    electrum restore $ELECTRUM_MASTER_PUBLIC_KEY
  } || {
    echo "Wallet already exists; skipping..."
  }
  electrum daemon load_wallet
fi

# Wait forever
while true; do
  tail -f /dev/null & wait ${!}
done

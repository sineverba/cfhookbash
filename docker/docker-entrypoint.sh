#!/bin/sh
set -e

ACCOUNTS_DIR=/app/dehydrated/accounts
DATA_DIR=/app/dehydrated

if [ ! -f "$DATA_DIR/config" ]; then
    echo "Creating configuration file..."
    cp /dehydrated/config "$DATA_DIR/config"
fi

if [ ! -f "$DATA_DIR/dehydrated" ]; then
    echo "Creating dehydrated file..."
    cp /dehydrated/dehydrated "$DATA_DIR/dehydrated"
fi

if [ ! -f "$DATA_DIR/domains.txt" ]; then
    echo "Creating domains.txt file..."
    cp /dehydrated/domains.txt "$DATA_DIR/domains.txt"
fi

if [ ! -f "$DATA_DIR/config.sh" ]; then
    echo "Creating config.sh file..."
    cp /dehydrated/config.sh "$DATA_DIR/config.sh"
fi

if [ ! -f "$DATA_DIR/hook.sh" ]; then
    echo "Creating hook.sh file..."
    cp /dehydrated/hook.sh "$DATA_DIR/hook.sh"
fi

# Check if account is registered
if [ ! -d "$ACCOUNTS_DIR" ]; then
    echo "Registering account"
    ./app/dehydrated/dehydrated --register --accept-terms
    exit
fi
./app/dehydrated/dehydrated -c -t dns-01 -k '/app/dehydrated/hook.sh' -x
#!/bin/sh
set -e

ACCOUNTS_DIR=/app/dehydrated/accounts

# Check if account is registered
if [ ! -d "$ACCOUNTS_DIR" ]; then
    echo "Register account"
    ./app/dehydrated/dehydrated --register --accept-terms
fi
./app/dehydrated/dehydrated -c -t dns-01 -k '/app/hook/hook.sh' -x
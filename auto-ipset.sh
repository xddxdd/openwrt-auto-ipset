#!/bin/sh

IPSET=$1
URL=$2

ipset create "${IPSET}_v4" || true
ipset create "${IPSET}_v6" || true

while true; do
    TMP_FILE="/tmp/ipset_${IPSET}.txt"
    curl -fsSL "$URL" -o "$TMP_FILE" || {
        echo "Failed to download rules, retrying in 60s"
        sleep 60
        continue
    }

    {
        IPV4=$(grep -E "^[0-9\./]+$" "$TMP_FILE")
        echo "flush ${IPSET}_v4"
        for IP in $IPV4; do
            echo "add ${IPSET}_v4 ${IP}"
        done
    } | ipset restore -!

    {
        IPV6=$(grep -E "^[0-9a-f:\\./]*:[0-9a-f:\\./]*$" "$TMP_FILE")
        echo "flush ${IPSET}_v6"
        for IP in $IPV6; do
            echo "add ${IPSET}_v6 ${IP}"
        done
    } | ipset restore -!

    echo "Updated, next update in 3600s"
    sleep 3600
done

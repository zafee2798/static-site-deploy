#!/usr/bin/env bash
set -euo pipefail

SERVER_USER="${SERVER_USER:-root}"
SERVER_IP="${SERVER_IP:-206.81.9.66}"
SSH_KEY="${SSH_KEY:-$HOME/.ssh/id_ed25519}"
REMOTE_PATH="${REMOTE_PATH:-/var/www/html/}"
LOCAL_SITE_DIR="${LOCAL_SITE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/site/}"

echo "Deploying static site"
echo "  Local dir:  $LOCAL_SITE_DIR"
echo "  Remote:     ${SERVER_USER}@${SERVER_IP}:${REMOTE_PATH}"
echo "  SSH key:    $SSH_KEY"
echo

if [ ! -d "$LOCAL_SITE_DIR" ]; then
    echo "Error: local site directory '$LOCAL_SITE_DIR' not found." >&2
    exit 1
fi

rsync -avz --delete \
    -e "ssh -i ${SSH_KEY}" \
    "$LOCAL_SITE_DIR" \
    "${SERVER_USER}@${SERVER_IP}:${REMOTE_PATH}"

echo
echo "Deploy complete. Site should be live at: http://${SERVER_IP}/"

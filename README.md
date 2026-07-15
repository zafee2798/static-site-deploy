# Static Site Deployment with Nginx and rsync

Project URL: https://roadmap.sh/projects/static-site-server

A minimal static website (HTML/CSS/SVG) served by nginx on a remote
Linux server, deployed with a one-command deploy.sh script that uses
rsync over SSH to sync only changed files.

## What's in this repo

- site/index.html — the static page
- site/style.css — styling
- site/assets/server-icon.svg — image asset used on the page
- deploy.sh — syncs site/ to the remote server's nginx web root via rsync

## Server setup (one-time)

1. Provision a remote Linux server (Ubuntu droplet on DigitalOcean).
2. Confirm SSH access:
   ssh -i ~/.ssh/id_ed25519 root@<SERVER_IP>
3. Install nginx:
   sudo apt update
   sudo apt install -y nginx
   sudo systemctl enable --now nginx
4. Clear the default web root:
   sudo rm -rf /var/www/html/*

## Deploying with deploy.sh

deploy.sh uses rsync over SSH to copy the contents of the local site/
directory to the server's web root, only transferring files that
changed since the last sync.

Run it:
   chmod +x deploy.sh
   ./deploy.sh

## Verifying the deployment

Visit the server's IP in a browser:
   http://<SERVER_IP>/

Any edit to files in site/, followed by re-running ./deploy.sh, updates
the live site within seconds.

# Kerio Control VPN Client in Debian-based Docker-container

A little hack for those Arch Linux users who are currently suffering from that [ issue](https://aur.archlinux.org/packages/kerio-control-vpnclient/#comment-719061).

## Pre-Installation

1. `git clone https://github.com/dnlklmts/kerio-control-vpnclinet.git`
2. `cd ./kerio-control-vpnclinet`
3. Put the hostname of the remote Kerio VPN server and user credentials into [install.sh](./scripts/install.sh) file.

## Installation

1. Copy URL of the latest kvpnc verison into [Dockerfile](./Dockerfile).
1. Run `docker build -t kvpnc:latest .` inside the repository directory.

## Usage

* `./scripts/docker-kvpnc-start.sh kvpnc:latest` —  activate Kerio VPN tunnel.
* `./scripts/docker-kvpnc-stop.sh` — close VPN connection.

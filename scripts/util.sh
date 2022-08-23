#!/bin/bash
#
# set up for convinient

set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

apt update && apt upgrade -y

apt install -y neovim
apt install -y nmap
apt install -y mlocate

updatedb

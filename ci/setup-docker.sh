#!/usr/bin/env bash

# Preparar a Docker en Arch :: Setup Docker on Arch
# Public Domain (all other lines are in the public domain) (CC0) 2025 Roger Steve Ruiz
#
# This program is free software: you can redistribute it and/or modify it
# freely. It is in the public domain within the United States.
#
# The person who associated a work with this deed has dedicated the work to the
# public domain by waiving all of his or her rights to the work worldwide under
# copyright law, including all related and neighboring rights, to the extent
# allowed by law.
#
# You can copy, modify, distribute and perform the work, even for commercial
# purposes, all without asking permission.
#
# In no way are the patent or trademark rights of any person affected by CC0, nor
# are the rights that other persons may have in the work or in how the work is
# used, such as publicity or privacy rights.
#
# Unless expressly stated otherwise, the person who associated a work with this
# deed makes no warranties about the work, and disclaims liability for all uses of
# the work, to the fullest extent permitted by applicable law. When using or
# citing the work, you should not imply endorsement by the author or the affirmer.
#
# You should have received a copy of the CC0 1.0 Universal License along with
# this program. If not, see <https://creativecommons.org/publicdomain/zero/1.0/>.

# BEGIN {
# Copyright All Rights Reserved (lines denoted by comments) (C) 2019 Tim Schumacher
# source: https://git.sr.ht/~xaffe/takingstack/tree/develop/item/files/setup-docker.sh
# permalink: https://git.sr.ht/~xaffe/takingstack/tree/292e055fa6234ff4426c3d02510d85786d04433c/item/files/setup-docker.sh

# Enable bash strict mode
set -euo pipefail
IFS=$'\n\t'

sudo mount -t tmpfs -o size=4G /dev/null /dev/shm
sleep 2
sudo nohup dockerd --bip 172.18.0.1/16 </dev/null >/dev/null 2>&1 &
sudo usermod -aG docker "$(whoami)"

# } END

sudo systemctl start docker

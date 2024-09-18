#!/usr/bin/env bash

DIR="$(dirname $0)"
HOST="${1:-desktop}"

nixos-rebuild build-vm --flake $DIR#$HOST
exec $DIR/result/bin/run-nixos-vm

#!/usr/bin/env bash

set -e

pushd ~/nixos

# Exit if no changes
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

# # Reformat
# alejandra . &>/dev/null \
#   || ( alejandra . ; echo "formatting failed!" && exit 1)

# Display changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake .#default &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Commit changes with generation metadata
current=$(nixos-rebuild list-generations | grep current)
git commit -am "$1 [$current]"

popd

# Notify all OK!
echo "Rebuild OK!"
# notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

#!/usr/bin/env bash

set -e

pushd ~/nixos

# Reformat
alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

# Display changes
git diff -U0 -P '*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake .#default &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Notify all OK!
echo "Rebuild OK!"
# notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

# Commit changes with generation metadata
current=$(nixos-rebuild list-generations | grep current)
git commit -am "$1 [$current]"
git push

echo "Push OK!"

popd


{system, pkgs, ...}:
let
  rebuildCommand = {
    "x86_64-linux" = "nixos-rebuild switch --flake .#default";
    "aarch64-darwin" = "darwin-reubild switch --flake .#dQw4w9WgXcQ";
  }.${system};
in pkgs.writeShellApplication {
  name = "nixos-rebuild";
  runtimeInputs = [pkgs.git];
  text = ''
    set -e
    pushd ~/nixos

    echo "Rebuilding..."
    sudo ${rebuildCommand} --show-trace
    echo "Rebuild OK!"

    current=$(nixos-rebuild list-generations | grep current)
    msg=$(read -p "Commit message: " -r)
    git commit -am "$msg [$current]"

    read -p "Push? " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      git push
    fi

    popd
  '';
}

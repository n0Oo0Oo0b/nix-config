{system, pkgs, inputs, ...}:
let
  darwin-rebuild = "${inputs.nix-darwin.packages.${system}.darwin-rebuild}/bin/darwin-rebuild";
  args = {
    "x86_64-linux" = {
      rebuild = "sudo nixos-rebuild switch --flake .#default";
      cfgDir = "~/nixos";
      listGens = "nixos-rebuild list-generations";
    };
    "aarch64-darwin" = {
      rebuild = "${darwin-rebuild} switch --flake .#dQw4w9WgXcQ";
      cfgDir = "~/.config/home-manager";
      listGens = "${darwin-rebuild} --list-generations";
    };
  };
in pkgs.writeShellApplication {
  name = "nix-rebuild";
  runtimeInputs = [pkgs.git];
  text = with args.${system}; ''
    set -e
    pushd ${cfgDir}

    echo "Rebuilding..."
    ${rebuild} --show-trace
    echo "Rebuild OK!"

    current=$(${listGens} | grep current)
    msg=$(read -p "Commit message: " -r)
    git commit -am "$msg [$current]"

    read -p "Push? " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      git push
    fi

    popd
  '';
}

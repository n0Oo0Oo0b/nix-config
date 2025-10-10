{
  pkgs,
  system,
  inputs,
  ...
}:
let
  args = {
    "x86_64-linux" =
      let
        nixos-rebuild = pkgs.lib.getExe pkgs.nixos-rebuild;
      in
      {
        rebuild = "sudo ${nixos-rebuild} switch --flake .#default";
        cfgDir = "~/nix-config";
        listGens = "${nixos-rebuild} list-generations";
      };
    "aarch64-darwin" =
      let
        darwin-rebuild = pkgs.lib.getExe inputs.nix-darwin.packages.${system}.darwin-rebuild;
      in
      {
        rebuild = "${darwin-rebuild} switch --flake .#dQw4w9WgXcQ";
        cfgDir = "~/nix-config";
        listGens = "${darwin-rebuild} --list-generations";
      };
  };
in
pkgs.writeShellApplication {
  name = "nix-rebuild";
  runtimeInputs = [ pkgs.git ];
  text = with args.${system}; ''
    set -e
    pushd ${cfgDir}

    echo "Rebuilding..."
    ${rebuild} --show-trace
    echo "Rebuild OK!"

    current=$(${listGens} | grep current)
    msg=$(read -p "Commit message: " -r)
    git commit -am "$msg [$current]"

    git push

    popd
  '';
}

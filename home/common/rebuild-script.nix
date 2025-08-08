{
  writeShellApplication,
  git,
  hostname,
  system,
}:
let
  args."x86_64-linux" = {
    rebuild = "sudo nixos-rebuild switch --flake .#${hostname}";
    listGens = "nixos-rebuild list-generations";
  };
  args."aarch64-darwin" = {
    rebuild = "sudo darwin-rebuild switch --flake .#${hostname}";
    listGens = "sudo darwin-rebuild --list-generations";
  };
in
writeShellApplication {
  name = "nix-rebuild";
  runtimeInputs = [ git ];
  text = with args.${system}; ''
    set -e
    pushd ~/nix-config

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

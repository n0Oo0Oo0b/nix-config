{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";

    catppuccin.url = "github:catppuccin/nix";
    nvf.url = "github:notashelf/nvf";
    zen-browser.url = "github:MarceColl/zen-browser-flake";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    nvf,
    zen-browser,
    ...
  } @ inputs: let
    systems = ["x86_64-linux" "aarch64-darwin"];
    eachSystem = func: (nixpkgs.lib.attrsets.genAttrs systems func);
  in {
    packages = eachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      neovim = nvf.lib.neovimConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit system;};
        modules = [(import ./modules/nvf)];
      };
    in {
      neovim = neovim.neovim;

      rebuild =
        if system == "x86_64-linux"
        then
          pkgs.writeShellApplication {
            name = "nixos-rebuild";
            runtimeInputs = [pkgs.git];
            text = ''
              set -e
              pushd ~/nixos

              echo "Rebuilding..."
              sudo nixos-rebuild switch --flake .#default --show-trace
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
        else null;
    });

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit self inputs;};
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.catppuccin.nixosModules.catppuccin
      ];
    };

    darwinConfigurations."dQw4w9WgXcQ" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit self inputs;};
      modules = [
        ./hosts/macbook/configuration.nix
        inputs.home-manager.darwinModules.default
      ];
    };
  };
}

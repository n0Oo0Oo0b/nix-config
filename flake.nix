{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";

    catppuccin.url = "github:catppuccin/nix";
    nvf.url = "github:notashelf/nvf";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

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
    home-manager,
    catppuccin,
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
        modules = [ (import ./modules/nvf) ];
      };
    in {
      neovim = neovim.neovim;
      rebuild = import ./rebuild-script.nix { inherit system pkgs; };

      homeConfigurations.danielgu = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/macbook/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = { inherit self inputs; };
      };
    });

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit self inputs;};
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.default
        catppuccin.nixosModules.catppuccin
      ];
    };

    darwinConfigurations."dQw4w9WgXcQ" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit self inputs;};
      modules = [
        ./hosts/macbook/configuration.nix
        home-manager.darwinModules.default
      ];
    };
  };
}

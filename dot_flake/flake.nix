{
  description = "lystran's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
  };

  outputs = inputs@{
    self,
    nix-darwin,
    home-manager,
    determinate,
    ...
  }:
    let
      hostname = "ZYM-MacBook";
      username = "lystran";
    in {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs hostname username; };

        modules = [
          determinate.darwinModules.default
          home-manager.darwinModules.home-manager
          ./hosts/${hostname}

          {
            nixpkgs.hostPlatform = "aarch64-darwin";
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.primaryUser = username;

            users.users.${username}.home = "/Users/${username}";

            determinateNix.enable = true;

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs username; };
              users.${username} = import ./home/${username}.nix;
            };
          }
        ];
      };
    };
}

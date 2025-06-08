{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    nix = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ [
          ./nix
          "${mod}/programs/gamemode.nix"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"
          {
            home-manager = {
              users.hazed.imports =
                homeImports."hazed@nix";
              extraSpecialArgs = specialArgs;
            };
          }

          inputs.agenix.nixosModules.default
          inputs.chaotic.nixosModules.default
        ];
    };
  };
}

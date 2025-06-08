{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "hazed@nix" = [
      ../.
      ./nix
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "hazed_nix" = homeManagerConfiguration {
        modules = homeImports."hazed@nix";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}

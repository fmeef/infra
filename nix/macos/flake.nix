{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-gnuradio.url = "github:NixOS/nixpkgs?rev=95b4c71e9b4f4a977250879ec38628a6770665c8";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs =
    inputs@{
      self,
      home-manager,
      nix-darwin,
      nixpkgs-unstable,
      nixpkgs-master,
      nixpkgs-gnuradio,
      nixpkgs,
      ...
    }:
    {
      darwinConfigurations.clarity = nix-darwin.lib.darwinSystem rec {

        system = "aarch64-darwin";

        specialArgs = { inherit inputs; };

        modules =

          let
            unstable = import nixpkgs-unstable {
              inherit system;

              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };

            master = import nixpkgs-master {
              inherit system;

              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };

            stable = import nixpkgs {
              inherit system;
              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };
            gnuradionix = import nixpkgs-gnuradio {
              inherit system;
              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };

            config = import ./config.nix {};
          in
          [
            ./configuration.nix
            inputs.home-manager.darwinModules.home-manager
            {
              environment.systemPackages = with unstable; [
                gnupg
                openocd
              ];
            }
            {

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bac";
              home-manager.users."${config.main_user}" = (
                import ./home/home.nix {
                  stable = stable;
                  unstable = unstable;
                  master = master;
                  gnuradionix = gnuradionix;
                }
              );

            }
          ];
      };
    };
}

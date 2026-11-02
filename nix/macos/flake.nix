{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    # nixpkgs-brotli.url = "github:fmeef/nixpkgs/brotli-shit";
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
            overlay = (self: super: 
              let
                brotli = 
 super.brotli.overrideAttrs (oldAattrs: {               
                  src = super.fetchFromGitHub {
                    owner = "google";
                    repo = "brotli";
                    tag = "1.2.1";
                    hash = "sha256-llY72cYffDv0ugsH0p89xIPEbElV4L8u7U/Fe8hT3gI=";
                  };
                  version = "1.2.1";
              });
              in {
              inherit brotli;
              nodejs = super.nodejs.overrideAttrs (old: {       
                    doCheck = false;
                     doInstallCheck = false;
                     dontCheck = true;
              });

              
              nodejs-slim = super.nodejs-slim.overrideAttrs (old: {       
                    doCheck = false;
                     doInstallCheck = false;
                     dontCheck = true;
              });
                harfbuzz = super.harfbuzz.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                  
          tls = super.tls.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });


   
                                    protobuf = super.protobuf.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });
                  
                  nodejs-slim_24 = super.nodejs-slim_24.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });
                   libgit2 = super.libgit2.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                  
                 openapv = super.openapv.overrideAttrs (oldattrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                    });

                  python314 = super.python314.override {
                    packageOverrides = self: super: {

                      
                      rich = super.rich.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      
                      httpx2 = super.httpx2.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      buildPythonPackage = args: (super.buildPythonPackage args).overridePythonAttrs (_: {
                        doCheck = false;
                        doInstallCheck = false;
                      });
                  protobuf = super.protobuf.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                  
               uvloop = super.uvloop.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                    brotli = super.brotli.overridePythonAttrs (old: {
                        inherit (brotli) version src;
                    });
                    protobuf_36 = super.protobuf_36.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                      ipython = super.ipython.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      anyio = super.anyio.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      pytest = super.pytest.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      backrefs = super.backrefs.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });


                       mistune = super.mistune.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });


                      tornado = super.tornado.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });



                      dunamai = super.dunamai.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });


                     sqlparse = super.sqlparse.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });
                   };
                 };

                 
                  python313 = super.python313.override {
                    packageOverrides = self: super: {
                                    protobuf = super.protobuf.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });


                      buildPythonPackage = args: (super.buildPythonPackage args).overridePythonAttrs (_: {
                        doCheck = false;
                        doInstallCheck = false;
                      });

                  
                    brotli = super.brotli.overridePythonAttrs (old: {
                        inherit (brotli) version src;
                    });
                                    protobuf_36 = super.protobuf_36.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                  
                      httpx2 = super.httpx2.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                  
               uvloop = super.uvloop.overrideAttrs (oldAttrs: {
                      doCheck = false;
                      doInstallCheck = false;
                      dontCheck = true;
                  });

                      ipython = super.ipython.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      
                      rich = super.rich.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      anyio = super.anyio.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      pytest = super.pytest.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });

                      backrefs = super.backrefs.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });


                       mistune = super.mistune.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });


                      tornado = super.tornado.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });



                      dunamai = super.dunamai.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });


                     sqlparse = super.sqlparse.overrideAttrs (oldattrs: {
                        doCheck = false;
                        doInstallCheck = false;
                        dontCheck = true;
                      });
                   };
                 };
            });
            unstable = import nixpkgs-unstable {
              inherit system;
              overlays = [ overlay ];
              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };

            master = import nixpkgs-master {
              inherit system;
              # overlays = [ overlay ];
              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };

            stable = import nixpkgs {
              inherit system;
              # overlays = [ overlay ];
              config = {
                android_sdk.accept_license = true;
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
            };
            gnuradionix = import nixpkgs-gnuradio {
              inherit system;
              # overlays = [ overlay ];
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
                automake
                autoconf
                libtool
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

{ stable, unstable, master, gnuradionix, ... }:

{
  home.stateVersion = "25.11";
  targets.darwin.copyApps.enable = false;
  targets.darwin.linkApps.enable = true;
  home.packages = let
                  pname = "catnip";
                  version = "v3.3.1.0";
                  repo = stable.fetchgit {
                        url = "https://github.com/ElectronicCats/CatSniffer-Tools.git";
                        rev = "3633fff091dfb03170e68ee301c810491560df1a";
                        hash = "sha256-UId98HOLT8sx8Yj1QJaweS73F4/KfcgMR7TrrNycE/w=";
                  };   
                  catnip =
                    with unstable.python313Packages;
                    buildPythonPackage rec {
                      inherit pname version;
                      src = "${repo}/catnip";
                      doCheck = false;
                          dontUsePytestCheck = true;
    dontUsePythonImportsCheck = true;
                      pyproject = true;
                      dontCheckRuntimeDeps = true;
                      build-system = [ setuptools ];
                      propagatedBuildInputs = with unstable.python313Packages; [
                        click
                        cryptography
                        intelhex
                        # matplotlib
                        numpy
                        pyserial
                        pyusb
                        requests
                        rich
                        scapy
                        textual
                        magic
                      ];
                };

                catsnifferTUI = let
                  pname = "catsnifferTUI";
                  version = "v3.3.1.0";
                in
                  with unstable.python313Packages;
                  buildPythonPackage rec {
                    inherit pname version;
                    src = "${repo}/catsnifferTUI";
                    doCheck = false;
                    pyproject = false;
                        dontUsePytestCheck = true;
    dontUsePythonImportsCheck = true;
                    dontCheckRuntimeDeps = true;
                    build-system = [ ];
                    propagatedBuildInputs = with unstable.python313Packages; [
                      click
                      cryptography
                      intelhex
                      # matplotlib
                      numpy
                      pyserial
                      pyusb
                      requests
                      rich
                      scapy
                      textual
                      magic
                    ];
              };
    in with stable; [
    master.zed-editor
    nil
    nixd
    master.vscode
    helix
    taskwarrior3
    unstable.yt-dlp
    unstable.mpv
    unstable.tor
    unstable.torsocks
    master.ollama
    ripgrep
    cmake
    pkg-config
    ninja
    wget
    git
    automake
    gnutar
    nasm
    meson 
    # (unstable.withPackages(ps: [ catnip ]))
    (master.python313.withPackages (ppkgs: with ppkgs; [    
      numpy
      scipy
      matplotlib
      pandas
      jupyter
      ollama
      catnip
      catsnifferTUI
      ipython
      # llama-index-llms-ollama
  ]))

    master.basedpyright
    # master.libiio
    # unstable.python313Packages.libiio
    # unstable.python312Packages.libiio
    # unstable.gnuradioMinimal

    # (master.libbladeRF.overrideAttrs (old: { doChek = false; }))
    (gnuradionix.gnuradio.override {
      extraPackages = with gnuradionix.gnuradioPackages; [
        osmosdr
        bladeRF
       # limesdr
      ];
    })
    # unstable.gnuradioPackages.bladeRF
    # unstable.gnuradioPackages.osmosdr
  ];
}

{ stable, unstable, master, ... }:

{
  home.stateVersion = "25.11";
  targets.darwin.copyApps.enable = false;
  targets.darwin.linkApps.enable = true;
  home.packages = with stable; [
    master.zed-editor
    nil
    nixd
    master.vscode
    helix
    taskwarrior3
    yt-dlp
    mpv
    unstable.tor
    unstable.torsocks
    ollama
    (python313.withPackages (ppkgs: with ppkgs; [    
      numpy
      scipy
      matplotlib
      pandas
      jupyter
      ollama
      llama-index-llms-ollama
  ]))

    unstable.basedpyright
    # master.libiio
    # unstable.python313Packages.libiio
    # unstable.python312Packages.libiio
    # unstable.gnuradioMinimal

    # (master.libbladeRF.overrideAttrs (old: { doChek = false; }))
    (master.gnuradio.override {
      extraPackages = with master.gnuradioPackages; [
        osmosdr
        bladeRF
       # limesdr
      ];
    })
    # unstable.gnuradioPackages.bladeRF
    # unstable.gnuradioPackages.osmosdr
  ];
}

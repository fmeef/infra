{ pkgs, ... }:

{

  users.users.khanson = {
    home = "/Users/khanson";
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  # If you're on an Intel system, replace with "x86_64-darwin"
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.fish.enable = true;

  environment.systemPackages = [ ];

  nix.extraOptions = ''
    auto-optimise-store = false
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}

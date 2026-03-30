{
  description = "Minimal NixOS installation media";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      exampleIso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
            environment.systemPackages = [ pkgs.neovim pkgs.openssh ];
            users.users.root = {
              openssh.authorizedKeys.keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+e4IIBPfyutgm99Adl7S8FxCeFC///JAf0rtOqXdSYshE2fdo4Uaxonvs45oz6u9eyJ0X6OR3X8CYzgg32K2D+f4sjo+Ca6Di7tyGRIIRZlJp56Se3EbdeZXo8PORFY+b0aaIBdGlTvwIi/SxxTta4vycI/KSTmLN0iERw3sUveQBkLs+cBk1ZZUUJEotLQ6QsaexdtRplFjAsf2c6bDzdK1h/T/Z0lZ01BMl5HcOwPgEqqUYGVxyKvoI07B+7qEDTf8V1qZD/hyssayE7RaQnEteCrX5LmYJaH40vUIQVJoGOAln5JydCgT3LVCiQWNSAAzvH4vHC56vh2hlgoQ0daMuqq6eGmzwCCQAwx4wgMpA4sP8j/9/WvtSGOBzDhMZYWH6AKJg0kRIWLvCIbhUL/BGyW4bSn9pwvj+GqmnfbCj/Ggnz1Y3CYWFZ2yeX1VcmU6TsKDCVVQKdUR31A0iYdQHhXjvKJG7ZT0ievp1aZG+DCLuBQO5Zw9kv+x/gaHG4iHEUelFiFItubx1kWsIAz2Zr5vjEHh+Iv56us5GsQJUh71Ino86Yj1UtkmIw5aDaX1/HwaJHRvQ5iDxC74AyV2KbPJoSe0VPRCDjUR0qk9xjjcoA48J4ot/lWdIijzPIzreUgU4rUkTWp+g/0rfE4DhXKA2jYCzH+k2tGT7Vw== user@work"
              ];
            };
          })
        ];
      };
    };
  };
}

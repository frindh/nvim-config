{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: {
      default = import ./my-nvim.nix { 
        pkgs = nixpkgs.legacyPackages.${system}; 
      };
    });
  };
}

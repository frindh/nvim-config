## Quick iteration of lua configuration files

To use the local configuration set the environment variable `USE_LOCAL_CONFIG=1`.

```
USE_LOCAL_CONFIG=1 nvim
```

Symlink the lua configuration in the repo to the default location expected by nvim.

```
ln -s ~/nixos-config/nvim-config/config ~/.config/nvim
```

## Usage as a flake

**Local path:**
```nix
nvim-config = {
  url = "path:/path/to/nvim-config";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

**GitHub:**
```nix
nvim-config = {
  url = "github:yourusername/nvim-config";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Then use in your configuration:
```nix
environment.systemPackages = [
  inputs.nvim-config.packages.${pkgs.system}.default
];
```

Update the flake input:
```bash
nix flake update nvim-config
```

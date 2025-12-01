{ pkgs, ... }:

let
  # Tools and LSP servers available to Neovim
  lspTools = with pkgs; [
    lua-language-server
    nixd
    alejandra
    gopls
    pyright
    ruff
    rust-analyzer
    wl-clipboard
    xclip
  ];

  # Treesitter bundle
  nvimTreesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.tree-sitter-bash
    p.tree-sitter-python
    p.tree-sitter-nix
    p.tree-sitter-lua
    p.tree-sitter-go
    p.tree-sitter-rust
  ]);

  # XDG config directory for Neovim (used when USE_LOCAL_CONFIG is not set to 1)
  nvimConfig = pkgs.stdenv.mkDerivation {
    name = "nvim-xdg-config";
    src = ./config;
    installPhase = ''
      mkdir -p $out/nvim
      cp -r . $out/nvim/
    '';
  };

  # Build Neovim with plugins
  nvimWithPlugins = pkgs.neovim.override {
    configure = {
      customRC = ''
        lua << EOF
          -- Bootstrap actual init.lua from XDG config or fallback
          local config_home = os.getenv("XDG_CONFIG_HOME") or vim.fn.expand("~/.config")
          local init = config_home .. "/nvim/init.lua"

          if vim.fn.filereadable(init) == 1 then
            dofile(init)
          else
            vim.notify("init.lua not found at " .. init, vim.log.levels.ERROR)
          end

        -- ${builtins.readFile ./config/init.lua}
        EOF
      '';

      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          # collection of LSP server configurations
          nvim-lspconfig
          # autocompletion
          blink-cmp
          friendly-snippets   
          mini-pairs
          mini-files
          mini-icons
          #oil-nvim
          nvimTreesitter  # syntax highlighting
          telescope-nvim  # fuzzy search for files etc.
          telescope-fzf-native-nvim
          plenary-nvim  # dependency for telescope
          kanagawa-nvim
        ];
      };
    };
  };

  # Neovim wrapper with PATH containing LSP servers
  nvimWrapped = pkgs.writeShellScriptBin "nvim" ''
    export PATH="${pkgs.lib.makeBinPath lspTools}:$PATH"

    # toggle packaged vs local config
    if [[ -f "$HOME/.use-local-nvim" ]] || [[ "''${USE_LOCAL_CONFIG:-}" == "1" ]]; then
      unset XDG_CONFIG_HOME
      exec ${nvimWithPlugins}/bin/nvim "$@"
    else
      export XDG_CONFIG_HOME="${nvimConfig}"
      exec ${nvimWithPlugins}/bin/nvim "$@"
    fi
  '';
in

nvimWrapped


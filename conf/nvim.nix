{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      fzf-lua
      gitsigns-nvim
      nvim-treesitter
    ];
  };

  home.packages = with pkgs; [
    ripgrep
    fd

    nodePackages.typescript-language-server
    typescript
    pyright
  ];

  home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
  home.file.".config/nvim/lua/options.lua".source = ./nvim/lua/options.lua;
  home.file.".config/nvim/lua/plugins/lsp.lua".source = ./nvim/lua/plugins/lsp.lua;
  home.file.".config/nvim/lua/plugins/fzf.lua".source = ./nvim/lua/plugins/fzf.lua;
  home.file.".config/nvim/lua/plugins/git.lua".source = ./nvim/lua/plugins/git.lua;
}

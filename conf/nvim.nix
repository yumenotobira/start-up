{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      fzf-lua
      gitsigns-nvim
      diffview-nvim
      neo-tree-nvim
      nvim-web-devicons
      plenary-nvim
      nui-nvim

      (nvim-treesitter.withPlugins (p: with p; [
        python

        javascript
        typescript
        tsx

        html
        css
        json
        yaml
        toml

        lua
        vim
        vimdoc

        bash
        markdown
        markdown_inline
      ]))
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
  home.file.".config/nvim/lua/keymaps.lua".source = ./nvim/lua/keymaps.lua;
  home.file.".config/nvim/lua/plugins/lsp.lua".source = ./nvim/lua/plugins/lsp.lua;
  home.file.".config/nvim/lua/plugins/fzf.lua".source = ./nvim/lua/plugins/fzf.lua;
  home.file.".config/nvim/lua/plugins/git.lua".source = ./nvim/lua/plugins/git.lua;
  home.file.".config/nvim/lua/plugins/treesitter.lua".source = ./nvim/lua/plugins/treesitter.lua;
  home.file.".config/nvim/lua/plugins/tree.lua".source = ./nvim/lua/plugins/tree.lua;
}

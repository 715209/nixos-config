{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    defaultEditor = true;
    plugins = with pkgs; [
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      # language servers
      lua-language-server
      rust-analyzer
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/colors.lua}
      ${builtins.readFile ./nvim/remap.lua}
      ${builtins.readFile ./nvim/set.lua}
      ${builtins.readFile ./nvim/plugins/lsp.lua}
    '';
  };
}

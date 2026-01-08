{ pkgs, ... }:
{
  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins = {
      # NOTE: disabled due to treesitter query file conflicts
      enable = false;
      standalonePlugins = with pkgs.vimPlugins; [
        "catppuccin-nvim"
        "neotest"
        "nvim-treesitter"
        "nvim-treesitter-refactor"
        "snacks-nvim"
        mini-nvim
        overseer-nvim
        vs-tasks-nvim
      ];
    };
  };
}

{pkgs, ...}: {
  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins = {
      enable = true;
      standalonePlugins = with pkgs.vimPlugins; [
        "neotest"
        "nvim-treesitter"
        mini-nvim
        overseer-nvim
        vs-tasks-nvim
      ];
    };
  };
}

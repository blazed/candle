{
  config,
  lib,
  ...
}:
{
  plugins = {
    treesitter = {
      enable = true;

      folding.enable = true;
      grammarPackages = config.plugins.treesitter.package.passthru.allGrammars;
      nixvimInjections = true;

      # nvim-treesitter main branch: highlighting/indent are driven by Nixvim's
      # native treesitter setup rather than the legacy `settings` module options.
      # Large-file handling is covered by `plugins.snacks` bigfile.
      highlight.enable = true;
      indent.enable = true;
    };
  };

  keymaps = lib.mkIf config.plugins.treesitter-context.enable [
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>TSContextToggle<cr>";
      options = {
        desc = "Treesitter Context toggle";
      };
    }
  ];
}

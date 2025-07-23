{
  config,
  lib,
  self,
  system,
  ...
}:
{
  plugins = {
    treesitter = {
      enable = true;

      folding = true;
      grammarPackages = config.plugins.treesitter.package.passthru.allGrammars;
      nixvimInjections = true;

      settings = {
        highlight = {
          additional_vim_regex_highlighting = true;
          enable = true;
          disable =
            # Lua
            ''
              function(lang, bufnr)
                return vim.api.nvim_buf_line_count(bufnr) > 10000
              end
            '';
        };

        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "gnn";
            node_incremental = "grn";
            scope_incremental = "grc";
            node_decremental = "grm";
          };
        };

        indent = {
          enable = true;
        };
      };
    };

    treesitter-refactor = {
      inherit (config.plugins.treesitter) enable;

      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = true;
      };
      smartRename = {
        enable = true;
        keymaps = {
          # NOTE: default is "grr"
          # Changed from grR to gR to avoid conflict with gr (References)
          smartRename = "gR";
        };
      };
      navigation = {
        enable = true;
      };
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

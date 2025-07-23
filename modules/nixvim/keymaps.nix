{
  helpers,
  lib,
  ...
}:
{
  globals = {
    mapleader = ",";
    maplocalleader = ",";
  };

  keymaps =
    let
      normal =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "n";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            "<space>" = {
              action = "<Cmd>silent noh<CR>";
              options = {
                desc = "Drop search highlight";
              };
            };
            "Y" = {
              action = "y$";
            };

            "<leader>." = {
              action = "<c-^>";
              options = {
                desc = "Toggle between buffers";
              };
            };

            "<C-Up>" = {
              action = "<cmd>resize -2<CR>";
            };
            "<C-Down>" = {
              action = "<cmd>resize +2<CR>";
            };
            "<C-Left>" = {
              action = "<cmd>vertical resize +2<CR>";
            };
            "<C-Right>" = {
              action = "<cmd>vertical resize -2<CR>";
            };

            "<M-Up>" = {
              action = "<Cmd>move-2<CR>";
              options = {
                desc = "Move line up";
              };
            };
            "<M-Down>" = {
              action = "<Cmd>move+<CR>";
              options = {
                desc = "Move line down";
              };
            };
            "j" = {
              action = "v:count == 0 ? 'gj' : 'j'";
              options = {
                desc = "Move cursor down";
                expr = true;
              };
            };
            "k" = {
              action = "v:count == 0 ? 'gk' : 'k'";
              options = {
                desc = "Move cursor up";
                expr = true;
              };
            };
            "|" = {
              action = "<Cmd>vsplit<CR>";
              options = {
                desc = "Vertical split";
              };
            };
            "-" = {
              action = "<Cmd>split<CR>";
              options = {
                desc = "Horizontal split";
              };
            };
            "<leader>b]" = {
              action = "<cmd>bnext<CR>";
              options = {
                desc = "Next buffer";
              };
            };
            "<TAB>" = {
              action = "<cmd>bnext<CR>";
              options = {
                desc = "Next buffer (default)";
              };
            };
            "<leader>b[" = {
              action = "<cmd>bprevious<CR>";
              options = {
                desc = "Previous buffer";
              };
            };
            "<S-TAB>" = {
              action = "<cmd>bprevious<CR>";
              options = {
                desc = "Previous buffer";
              };
            };
            "<leader>ud" = {
              action.__raw = ''
                function ()
                  vim.b.disable_diagnostics = not vim.b.disable_diagnostics
                  if vim.b.disable_diagnostics then
                    vim.diagnostic.disable(0)
                  else
                    vim.diagnostic.enable(0)
                  end
                  vim.notify(string.format("Buffer Diagnostics %s", bool2str(not vim.b.disable_diagnostics), "info"))
                end'';
              options = {
                desc = "Buffer Diagnostics toggle";
              };
            };

            "<leader>uD" = {
              action.__raw = ''
                function ()
                  vim.g.disable_diagnostics = not vim.g.disable_diagnostics
                  if vim.g.disable_diagnostics then
                    vim.diagnostic.disable()
                  else
                    vim.diagnostic.enable()
                  end
                  vim.notify(string.format("Global Diagnostics %s", bool2str(not vim.g.disable_diagnostics), "info"))
                end'';
              options = {
                desc = "Global Diagnostics toggle";
              };
            };

            "<leader>uf" = {
              action.__raw = ''
                function ()
                  -- vim.g.disable_autoformat = not vim.g.disable_autoformat
                  vim.cmd('FormatToggle!')
                  vim.notify(string.format("Buffer Autoformatting %s", bool2str(not vim.b[0].disable_autoformat), "info"))
                end'';
              options = {
                desc = "Buffer Autoformatting toggle";
              };
            };

            "<leader>uF" = {
              action.__raw = ''
                function ()
                  -- vim.g.disable_autoformat = not vim.g.disable_autoformat
                  vim.cmd('FormatToggle')
                  vim.notify(string.format("Global Autoformatting %s", bool2str(not vim.g.disable_autoformat), "info"))
                end'';
              options = {
                desc = "Global Autoformatting toggle";
              };
            };

            "<leader>uS" = {
              action.__raw = ''
                function ()
                  if vim.g.spell_enabled then vim.cmd('setlocal nospell') end
                  if not vim.g.spell_enabled then vim.cmd('setlocal spell') end
                  vim.g.spell_enabled = not vim.g.spell_enabled
                  vim.notify(string.format("Spell %s", bool2str(vim.g.spell_enabled), "info"))
                end'';
              options = {
                desc = "Spell toggle";
              };
            };

            "<leader>uw" = {
              action.__raw = ''
                function ()
                  vim.wo.wrap = not vim.wo.wrap
                  vim.notify(string.format("Wrap %s", bool2str(vim.wo.wrap), "info"))
                end'';
              options = {
                desc = "Word Wrap toggle";
              };
            };
          };
      visual =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "v";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Better indenting
            "<S-Tab>" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<" = {
              action = "<gv";
              options = {
                desc = "Unindent line";
              };
            };
            "<Tab>" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };
            ">" = {
              action = ">gv";
              options = {
                desc = "Indent line";
              };
            };
          };
      insert =
        lib.mapAttrsToList
          (
            key:
            { action, ... }@attrs:
            {
              mode = "i";
              inherit action key;
              options = attrs.options or { };
            }
          )
          {
            # Move selected line/block in insert mode
            "<C-k>" = {
              action = "<C-o>gk";
            };
            "<C-h>" = {
              action = "<Left>";
            };
            "<C-l>" = {
              action = "<Right>";
            };
            "<C-j>" = {
              action = "<C-o>gj";
            };
          };
    in
    helpers.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>/";
      icon = "";
    }
    {
      __unkeyed-1 = "<leader>a";
      group = "AI Assistant";
      icon = "";
    }
  ];
}

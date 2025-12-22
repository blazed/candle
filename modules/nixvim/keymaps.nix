{
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

            "<C-c>" = {
              action = "<c-^>";
              options = {
                desc = "Toggle between buffers";
              };
            };

            "<leader>[" = {
              action = "<C-w>h";
              options = {
                desc = "Left window";
              };
            };
            "<leader>]" = {
              action = "<C-w>l";
              options = {
                desc = "Right window";
              };
            };
            "<leader>." = {
              action = "<C-w>j";
              options = {
                desc = "Up window";
              };
            };
            "<leader>," = {
              action = "<C-w>k";
              options = {
                desc = "Down window";
              };
            };

            # navigate quickfix list
            "<C-[>" = {
              action = "<cmd>cnext<CR>";
            };
            "<C-]>" = {
              action = "<cmd>cprev<CR>";
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

            "<leader>uh" = {
              action.__raw = ''
                function ()
                  local curr_foldcolumn = vim.wo.foldcolumn
                  if curr_foldcolumn ~= "0" then vim.g.last_active_foldcolumn = curr_foldcolumn end
                  vim.wo.foldcolumn = curr_foldcolumn == "0" and (vim.g.last_active_foldcolumn or "1") or "0"
                  vim.notify(string.format("Fold Column %s", bool2str(vim.wo.foldcolumn), "info"))
                end'';
              options = {
                desc = "Fold Column toggle";
              };
            };

            "<leader>uT" = {
              action = "<cmd>TabsToggle<CR>";
              options = {
                desc = "Toggle tabs/spaces";
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
            "K" = {
              action = "<cmd>m '<-2<CR>gv=gv<cr>";
            };
            "J" = {
              action = "<cmd>m '>+1<CR>gv=gv<cr>";
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
    lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ insert);

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

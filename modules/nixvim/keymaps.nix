{
  helpers,
  lib,
  ...
}: {
  globals = {
    mapleader = ",";
    maplocalleader = ",";
  };

  keymaps = let
    normal =
      lib.mapAttrsToList
      (
        key: {action, ...} @ attrs: {
          mode = "n";
          inherit action key;
          options = attrs.options or {};
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
        "|" = {
          action = "<Cmd>vplit<CR>";
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
      };
    visual =
      lib.mapAttrsToList
      (
        key: {action, ...} @ attrs: {
          mode = "v";
          inherit action key;
          options = attrs.options or {};
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
        key: {action, ...} @ attrs: {
          mode = "i";
          inherit action key;
          options = attrs.options or {};
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
    helpers.keymaps.mkKeymaps {options.silent = true;} (normal ++ visual ++ insert);

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

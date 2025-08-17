{
  config,
  pkgs,
  lib,
  ...
}:
{
  extraPlugins = with pkgs.vimPlugins; [
    claudecode-nvim
  ];

  extraConfigLua = ''
    require("claudecode").setup({})
  '';

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>ac";
      group = "Claude Code";
      icon = "";
    }
  ];
  # };

  keymaps = [
    {
      key = "<leader>act";
      action = "<cmd>ClaudeCode<CR>";
      options = {
        desc = "Toggle Claude";
      };
    }
    {
      key = "<leader>acf";
      action = "<cmd>ClaudeCodeFocus<CR>";
      options = {
        desc = "Focus Claude";
      };
    }
    {
      key = "<leader>acab";
      action = "<cmd>ClaudeCode Add %<CR>";
      options = {
        desc = "Add current buffer";
      };
    }
    {
      key = "<leader>acs";
      action = "<cmd>ClaudeCodeSend<CR>";
      options = {
        desc = "Send to Claude";
      };
    }
    {
      key = "<leader>acc";
      action = "<cmd>ClaudeCode --continue<CR>";
      options = {
        desc = "Continue Claude";
      };
    }
    {
      key = "<leader>acr";
      action = "<cmd>ClaudeCode --resume<CR>";
      options = {
        desc = "Resume Claude";
      };
    }
    {
      key = "<leader>acaa";
      action = "<cmd>ClaudeCodeDiffAccept<CR>";
      options = {
        desc = "Accept Diff";
      };
    }
    {
      key = "<leader>acad";
      action = "<cmd>ClaudeCodeDiffDeny<CR>";
      options = {
        desc = "Deny Diff";
      };
    }
  ];
}

{
  config,
  lib,
  ...
}:
{
  plugins = {
    claude-code = {
      enable = true;
      lazyLoad.settings.cmd = [
        "ClaudeCode"
        "CloudeCodeContinue"
        "ClaudeCodeResume"
        "ClaudeCodeVerbose"
      ];

      settings = {
        window = {
          position = "vertical";
        };
        shell = {
          separator = ";";
          pushd_cmd = "use std/dirs shells-aliases *; enter";
          popd_cmd = "exit";
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.claude-code.enable [
      {
        __unkeyed-1 = "<leader>ac";
        group = "Cloude Code";
        icon = "";
      }
    ];
  };

  keymaps = lib.mkIf config.plugins.claude-code.enable [
    {
      key = "<leader>act";
      action = "<cmd>ClaudeCode<CR>";
      options = {
        desc = "Toggle Claude";
      };
    }
    {
      key = "<leader>acc";
      action = "<cmd>ClaudeCodeContinue<CR>";
      options = {
        desc = "Continue Claude";
      };
    }
    {
      key = "<leader>acr";
      action = "<cmd>ClaudeCodeResume<CR>";
      options = {
        desc = "Resume Claude";
      };
    }
    {
      key = "<leader>acv";
      action = "<cmd>ClaudeCodeVerbose<CR>";
      options = {
        desc = "Verbose Claude";
      };
    }
  ];
}

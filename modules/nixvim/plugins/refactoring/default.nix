{ config, lib, ... }:
{
  plugins = {
    refactoring = {
      enable = true;

      settings = {
        prompt_func_return_type = {
          go = true;
        };

        prompt_func_param_type = {
          go = true;
        };

        printf_statements = {
          go = [
            "fmt.Printf(\"[DEBUG] %s\\n\", \"%s\")"
            "log.Printf(\"[DEBUG] %s\", \"%s\")"
            "slog.Debug(\"%s\")"
          ];
          rust = [
            "println!(\"[DEBUG] {}\", \"%s\");"
            "eprintln!(\"[DEBUG] {}\", \"%s\");"
            "log::debug!(\"%s\");"
            "tracing::debug!(\"%s\");"
          ];
          python = [
            "print(f\"[DEBUG] %s\")"
            "logging.debug(\"%s\")"
            "logger.debug(\"%s\")"
          ];
          javascript = [
            "console.log('[DEBUG] %s');"
            "console.debug('[DEBUG] %s');"
            "logger.debug('%s');"
          ];
          typescript = [
            "console.log('[DEBUG] %s');"
            "console.debug('[DEBUG] %s');"
            "logger.debug('%s');"
          ];
        };

        print_var_statements = {
          go = [
            "fmt.Printf(\"%s: %%+v\\n\", %s)"
            "fmt.Printf(\"%s: %%#v\\n\", %s)"
            "log.Printf(\"%s: %%v\", %s)"
          ];
          rust = [
            "println!(\"%s: {:?}\", %s);"
            "println!(\"%s: {:#?}\", %s);"
            "dbg!(%s);"
            "eprintln!(\"%s: {:?}\", %s);"
          ];
          python = [
            "print(f\"%s: {%s}\")"
            "print(f\"%s: {%s!r}\")"
            "logging.debug(f\"%s: {%s}\")"
            "pprint.pprint({\"%s\": %s})"
          ];
          javascript = [
            "console.log('%s:', %s);"
            "console.debug('%s:', %s);"
            "console.log('%s:', JSON.stringify(%s, null, 2));"
          ];
          typescript = [
            "console.log('%s:', %s);"
            "console.debug('%s:', %s);"
            "console.log('%s:', JSON.stringify(%s, null, 2));"
          ];
        };
      };

      lazyLoad = {
        settings = {
          cmd = "Refactor";
        };
      };
    };
  };

  keymaps = lib.mkIf config.plugins.refactoring.enable [
    # Extract operations (visual mode)
    {
      mode = "x";
      key = "<leader>re";
      action = "<cmd>Refactor extract<cr>";
      options = {
        desc = "Extract Function";
      };
    }
    {
      mode = "x";
      key = "<leader>rE";
      action = "<cmd>Refactor extract_to_file<cr>";
      options = {
        desc = "Extract Function to File";
      };
    }
    {
      mode = "x";
      key = "<leader>rv";
      action = "<cmd>Refactor extract_var<cr>";
      options = {
        desc = "Extract Variable";
      };
    }

    # Inline operations (normal mode)
    {
      mode = "n";
      key = "<leader>ri";
      action = "<cmd>Refactor inline_var<CR>";
      options = {
        desc = "Inline Variable";
      };
    }
    {
      mode = "n";
      key = "<leader>rI";
      action = "<cmd>Refactor inline_func<CR>";
      options = {
        desc = "Inline Function";
      };
    }

    # Block operations (normal mode)
    {
      mode = "n";
      key = "<leader>rb";
      action = "<cmd>Refactor extract_block<CR>";
      options = {
        desc = "Extract Block";
      };
    }
    {
      mode = "n";
      key = "<leader>rB";
      action = "<cmd>Refactor extract_block_to_file<CR>";
      options = {
        desc = "Extract Block to File";
      };
    }

    # Debug operations (based on documentation)
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>rp";
      action.__raw = ''
        function()
          require('refactoring').debug.printf({below = false})
        end
      '';
      options = {
        desc = "Debug Printf";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>rP";
      action.__raw = ''
        function()
          require('refactoring').debug.print_var()
        end
      '';
      options = {
        desc = "Debug Print Variable";
      };
    }
    {
      mode = "n";
      key = "<leader>rc";
      action.__raw = ''
        function()
          require('refactoring').debug.cleanup({})
        end
      '';
      options = {
        desc = "Debug Cleanup";
      };
    }
  ];
}

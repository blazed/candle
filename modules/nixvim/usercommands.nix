{
  userCommands = {
    FormatDisable = {
      bang = true;
      command.__raw = ''
        function(args)
           if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end
      '';
      desc = "Disable automatic formatting on save";
    };

    FormatEnable = {
      bang = true;
      command.__raw = ''
        function(args)
           if args.bang then
            -- FormatEnable! will enable formatting just for this buffer
            vim.b.disable_autoformat = false
          else
            vim.g.disable_autoformat = false
          end
        end
      '';
      desc = "Enable automatic formatting on save";
    };

    FormatToggle = {
      bang = true;
      command.__raw = ''
        function(args)
          if args.bang then
            -- Toggle formatting for current buffer
            vim.b.disable_autoformat = not vim.b.disable_autoformat
          else
            -- Toggle formatting globally
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end
        end
      '';
      desc = "Toggle automatic formatting on save";
    };

    TabsToggle = {
      command.__raw = ''
        function()
          vim.bo.expandtab = not vim.bo.expandtab
          local mode = vim.bo.expandtab and "spaces" or "tabs"
          vim.notify("Switched to " .. mode, "info")
        end
      '';
      desc = "Toggle between tabs and spaces";
    };

    RemoveTrailingNewline = {
      command = ''execute '%s/\\n\\+$/\\/e' '';
    };

    PeekDefinition = {
      nargs = 1;
      command.__raw = ''
        function(opts)
          local function preview_location_callback(_, result)
            if result == nil or vim.tbl_isempty(result) then
              vim.notify('No location found to preview')
              return nil
            end
            if not result[1] then
              vim.notify('Cant peek location')
              return nil
            end
          local buf, _ = vim.lsp.util.preview_location(result[1])
            if buf then
              local cur_buf = vim.api.nvim_get_current_buf()
              vim.bo[buf].filetype = vim.bo[cur_buf].filetype
            end
          end

          local params = vim.lsp.util.make_position_params()
          return vim.lsp.buf_request(0, opts.fargs[1], params, preview_location_callback)
        end
      '';
    };

    ToggleBeastMode = {
      command.__raw = ''
        function()
          require("avante.config").override({
            system_prompt = ${builtins.toJSON (builtins.readFile ./custom-prompts/beast-mode.md)}
          })
          vim.notify("Avante Beast Mode enabled")
        end
      '';
      desc = "Toggle Avante Beast Mode system prompt";
    };
  };
}

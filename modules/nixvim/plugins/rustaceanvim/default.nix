{
  lib,
  pkgs,
  ...
}:
{
  # Needed for RustPlay
  extraPlugins = with pkgs.vimPlugins; [ webapi-vim ];

  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        dap = {
          adapter = {
            command = lib.getExe' pkgs.lldb "lldb-dap";
            type = "executable";
          };
          autoloadConfigurations = true;
        };

        server = {
          default_settings = {
            rust-analyzer = {
              cargo = {
                buildScripts.enable = true;
                features = "all";
              };

              diagnostics = {
                enable = true;
                styleLints.enable = true;
              };

              checkOnSave = true;
              check = {
                command = "clippy";
                features = "all";
              };

              files = {
                excludeDirs = [
                  ".cargo"
                  ".direnv"
                  ".git"
                  "node_modules"
                  "target"
                ];
              };

              inlayHints = {
                chaningHints.enable = false;
                closingBraceHints.enable = false;
                genericParameterHints.const.enable = false;
                parameterHints.enable = false;
                renderColons = false;
                typeHints.enable = false;

                bindingModeHints.enable = false;
                closureStyle = "rust_analyzer";
                closureReturnTypeHints.enable = "never";
                discriminantHints.enable = "never";
                expressionAdjustmentHints.enable = "never";
                implicitDrops.enable = false;
                lifetimeElisionHints.enable = "never";
                rangeExclusiveHints.enable = false;
              };

              procMacro = {
                enable = true;
              };

              rustc.source = "discover";
            };
          };
        };
        tools.enable_clippy = true;
      };
    };
  };
}

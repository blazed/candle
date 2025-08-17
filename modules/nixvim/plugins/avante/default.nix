{
  config,
  lib,
  ...
}:
{
  plugins = {
    avante = {
      enable = true;

      lazyLoad.settings.event = [ "DeferredUIEnter" ];

      settings = {
        provider = "lmstudio";
        auto_suggestions_provider = "lmstudio";
        providers = {
          lmstudio = {
            __inherited_from = "openai";
            endpoint = "http://localhost:1234/v1";
            model = "unsloth/gpt-oss-20b";
            api_key_name = "LM_API_KEY";
          };
          lmstudio-qwen3-q4 = {
            __inherited_from = "openai";
            endpoint = "http://localhost:1234/v1";
            model = "qwen3-coder-30b-a3b-instruct@q4_1";
            api_key_name = "LM_API_KEY";
          };
          lmstudio-qwen3-q8 = {
            __inherited_from = "openai";
            endpoint = "http://localhost:1234/v1";
            model = "qwen3-coder-30b-a3b-instruct@q8_k_xl";
            api_key_name = "LM_API_KEY";
          };
          lmstudio-uigen = {
            __inherited_from = "openai";
            endpoint = "http://localhost:1234/v1";
            model = "tesslate_uigen-x-32b-0727";
            api_key_name = "LM_API_KEY";
          };
        };
        mappings = {
          ask = "<leader>aaa";
          new_ask = "<leader>aan";
          edit = "<leader>aae";
          refresh = "<leader>aar";
          focus = "<leader>aaf";
          stop = "<leader>aaS";
          toggle = {
            default = "<leader>aat";
            debug = "<leader>aad";
            hint = "<leader>aah";
            suggestion = "<leader>aas";
            repomap = "<leader>aaR";
          };
          files = {
            add_current = "<leader>aa.";
            add_all_buffers = "<leader>aaB";
          };
          select_model = "<leader>aa?";
          select_history = "<leader>aah";
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.avante.enable [
      {
        __unkeyed-1 = "<leader>aa";
        group = "Avante";
        icon = "";
      }
    ];
  };

  keymaps = lib.optionals config.plugins.avante.enable [
    {
      mode = "n";
      key = "<leader>aac";
      action = "<CMD>AvanteClear<CR>";
      options.desc = "avante: clear";
    }
  ];
}

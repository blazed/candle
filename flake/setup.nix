{
  inputs,
  lib,
  ...
}:
{
  perSystem =
    {
      config,
      system,
      ...
    }:
    let
      inherit (lib // builtins) filterAttrs match;
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (
            _final: _prev:
            (filterAttrs (
              name: _: ((match "nu-.*" name == null) && (match "nu_.*" name == null))
            ) config.packages)
          )
        ];
      };

      packages.default = config.packages.candle;
    };
}

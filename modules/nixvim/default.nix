{
  lib,
  self,
  ...
}:
{
  imports =
    (lib.attrsets.foldlAttrs (
      prev: name: type:
      prev ++ lib.lists.optional (type == "directory") (./plugins + "/${name}")
    ) [ ] (builtins.readDir ./plugins))
    ++ [
      # keep-sorted start
      ./autocommands.nix
      ./diagnostics.nix
      ./filetype.nix
      ./keymaps.nix
      ./lsp.nix
      ./lua.nix
      ./settings.nix
      ./performance.nix
      # keep-sorted end
    ];

  nixpkgs = {
    overlays = lib.attrValues self.overlays;
    config.allowUnfree = true;
  };
}

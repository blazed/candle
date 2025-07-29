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
      ./performance.nix
      ./settings.nix
      ./usercommands.nix
      # keep-sorted end
    ];

  nixpkgs = {
    overlays = lib.attrValues self.overlays;
    config.allowUnfree = true;
  };
}

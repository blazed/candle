{
  inputs,
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
    # Pin to the nixpkgs our flake input follows. Defining this explicitly
    # silences Nixvim's warning about its pinned nixpkgs being overridden by
    # `inputs.nixvim.inputs.nixpkgs.follows`.
    source = inputs.nixpkgs;
    overlays = lib.attrValues self.overlays;
    config.allowUnfree = true;
  };
}

{
  pkgs,
  ansiEscape,
  ...
}:
{
  name = "candle";

  packages = with pkgs; [
    nixfmt
    nixfmt-tree
    just
  ];

  enterShell = ansiEscape ''
     echo -e "
      {bold}{106}Candle{reset}
    "
  '';
}

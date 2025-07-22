{
  pkgs,
  ansiEscape,
  ...
}: {
  name = "candle";

  packages = with pkgs; [
    nixfmt
    just
  ];

  enterShell = ansiEscape ''
     echo -e "
      {bold}{106}Candle{reset}
    "
  '';
}

{
  pkgs,
  ansiEscape,
  ...
}: {
  name = "candle";

  packages = with pkgs; [
    alejandra
    just
  ];

  enterShell = ansiEscape ''
     echo -e "
      {bold}{106}Candle{reset}
    "
  '';
}

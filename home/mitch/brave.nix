{ config, lib, pkgs, ...}:
# Test line
{
  programs.brave = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "enpfonmmpgoinjpglildebkaphbhndek"; } # Proton?
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Tokyo Theme?
      { id = "gcbommkclmclpchllfjekcdonpmejbdp"; } # https everywhere
    ];
  };
}

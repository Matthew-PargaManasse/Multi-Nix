{
  config,
  lib,
  pkgs,
  ...
}:
# Test line
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "enpfonmmpgoinjpglildebkaphbhndek";} # Proton?
      {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # Tokyo Theme?
      {id = "gcbommkclmclpchllfjekcdonpmejbdp";} # https everywhere
    ];
    
    commandLineArgs = [
      "--password-store=basic" # Disables the KDE Wallet / Keyring popup
      "--force-dark-mode"      # Forces dark mode since Stylix is removed
    ];
  };
}

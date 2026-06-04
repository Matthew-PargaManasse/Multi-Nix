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
    # Enterprise policies to harden Brave and remove bloatware
    extraOpts = {
      "BraveWalletDisabled" = true;
      "BraveRewardsDisabled" = true;
      "BraveAIChatEnabled" = false; # Leo AI
      "BraveVPNDisabled" = true;
      "BraveNewsDisabled" = true;
      "BraveTalkDisabled" = true;
      # Disable background processing for privacy
      "BackgroundModeEnabled" = false;
      "MetricsReportingEnabled" = false;
    };
  };
}

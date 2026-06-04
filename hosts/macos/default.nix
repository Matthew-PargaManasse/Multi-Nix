{
  config,
  pkgs,
  ...
}: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  # Set state version for nix-darwin
  system.stateVersion = 4;
}

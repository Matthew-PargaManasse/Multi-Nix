{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./nvf.nix
    ./theme.nix
    ./wallust.nix
    ./brave.nix
  ];

  home.username = "mitch";
  home.homeDirectory = "/home/mitch";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    aircrack-ng
    bat
    btop
    dunst
    ventoy-bin
    brave
    burpsuite
    kdePackages.dolphin
    element-desktop
    eza
    flameshot
    fmt
    fzf
    gimp
    kitty
    metasploit
    plocate
    obsidian
    pipewire
    pkg-config
    protonmail-bridge
    proton-vpn
    ripgrep
    rofi
    signal-desktop
    slack
    terminator
    thunderbird
    virt-viewer
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-vscode.powershell
        redhat.vscode-yaml
      ];
    })
    tokyonight-gtk-theme
    haskellPackages.font-awesome-type
    gnome-tweaks
    gparted
    libsForQt5.qt5ct
  ];

  xdg.desktopEntries.antigravity = {
    name = "Antigravity";
    genericName = "AI Coding Assistant";
    exec = "antigravity";
    terminal = false;
    categories = [ "Development" "Utility" ];
    icon = "utilities-terminal";
  };

  xdg.desktopEntries."antigravity-ide" = {
    name = "Antigravity IDE";
    genericName = "AI IDE";
    exec = "antigravity-ide";
    terminal = false;
    categories = [ "Development" "IDE" ];
    icon = "code";
  };

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Tokyonight-Dark-B";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Matthew-PargaManasse";
        email = "LithoBreakerGB@gmail.com";
      };
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}

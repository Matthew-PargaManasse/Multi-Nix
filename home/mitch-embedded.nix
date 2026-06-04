{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./base.nix
  ];

  home.username = "mitch-embedded";
  home.homeDirectory = "/home/mitch-embedded";

  home.packages = with pkgs; [
    # Embedded systems exploitation tools
    wireshark
    tcpdump
    nmap
    aircrack-ng
    burpsuite
    metasploit

    # Extra embedded tooling
    radare2
    binutils
    openocd
    minicom
    picocom

    # IDEs / Dev
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
      ];
    })
  ];
}

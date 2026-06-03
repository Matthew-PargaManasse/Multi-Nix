{ config, pkgs, inputs, ... }:

{
  imports = [
    ./base.nix
    ./common/brave.nix
  ];

  home.username = "mitch";
  home.homeDirectory = "/home/mitch";

  home.packages = with pkgs; [
    # Hacking / Kali-style / OSCP tools
    aircrack-ng
    bloodhound
    burpsuite
    chisel
    dnsenum
    dnsrecon
    enum4linux
    evil-winrm
    exploitdb
    ffuf
    gobuster
    hashcat
    hydra
    uv # Blazingly fast Rust-based Python package manager (use `uv tool install` for impacket, certipy, cewl, wpscan, etc.)
    john
    masscan
    metasploit
    netcat-openbsd
    netexec
    nikto
    nmap
    nuclei
    proxychains
    rustscan
    samba
    socat
    sqlmap
    tcpdump
    wireshark
    # Utilities
    gparted
    kdePackages.dolphin
    
    # IDEs / Dev
    (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
            bbenoist.nix
            ms-python.python
            ms-vscode.powershell
            redhat.vscode-yaml
        ];
    })
  ];
}

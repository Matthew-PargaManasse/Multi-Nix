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
    certipy
    cewl
    chisel
    crunch
    dnsenum
    dnsrecon
    enum4linux
    evil-winrm
    exploitdb
    eyewitness
    ffuf
    gobuster
    hashcat
    hashid
    hydra
    uv # Blazingly fast Rust-based Python package manager (replaces pipx)
    john
    kerbrute
    ligolo-ng
    masscan
    metasploit
    netcat
    netexec
    nikto
    nmap
    nuclei
    onesixtyone
    proxychains
    responder
    rustscan
    samba
    smbmap
    socat
    sqlmap
    tcpdump
    wfuzz
    whatweb
    wireshark
    wpscan
    # Utilities
    unetbootin
    virtualbox
    virtualboxWithExtpack
    virt-viewer
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

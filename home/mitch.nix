{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./base.nix
    ./common/brave.nix
  ];

  home.username = "mitch";
  home.homeDirectory = "/home/mitch";

  home.packages = with pkgs; [
    # Hacking / Kali-style / OSCP tools
    aircrack-ng
    # bloodhound # TODO: Broken on aarch64
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

    # --- Wireless Attacks ---
    hcxdumptool
    hcxtools
    wifite2
    kismet
    reaverwps

    # --- Reverse Engineering & Forensics ---
    ghidra
    radare2
    binwalk
    autopsy
    volatility3

    # --- Information Gathering & OSINT ---
    theharvester
    recon-ng
    maltego

    # --- Exploitation & Sniffing ---
    bettercap
    responder

    # --- Passwords & Wordlists ---
    wordlists

    # --- Additional Protocols & Scanners ---
    net-snmp # provides snmpwalk
    freerdp # provides xfreerdp
    whatweb
    wfuzz

    # Utilities
    gparted
    kdePackages.dolphin
    (pkgs.callPackage ../pkgs/antigravity/default.nix {})
    (pkgs.callPackage ../pkgs/antigravity-ide/default.nix {})

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

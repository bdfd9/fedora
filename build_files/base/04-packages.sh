#!/usr/bin/env bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

packages=(
    # Audio / Firmware
    alsa-firmware
    alsa-sof-firmware
    alsa-tools-firmware
    atheros-firmware
    brcmfmac-firmware
    easyeffects
    intel-audio-firmware
    iwlegacy-firmware
    iwlwifi-dvm-firmware
    iwlwifi-mvm-firmware
    mt7xxx-firmware
    nxpwireless-firmware
    pipewire-plugin-libcamera
    pulseaudio-utils
    realtek-firmware
    tiwilink-firmware

    # Containers
    distrobox
    podman-compose
    podman-machine
    podman-tui
    podmansh
    systemd-container

    # Network / Connectivity
    gvfs-archive
    gvfs-mtp
    gvfs-nfs
    gvfs-smb
    iftop
    ifuse
    jmtpfs
    mobile-broadband-provider-info
    net-tools
    NetworkManager
    NetworkManager-adsl
    NetworkManager-bluetooth
    NetworkManager-config-connectivity-fedora
    NetworkManager-libnm
    NetworkManager-openconnect
    NetworkManager-openvpn
    NetworkManager-ssh
    NetworkManager-ssh-selinux
    NetworkManager-strongswan
    NetworkManager-vpnc
    NetworkManager-wifi
    NetworkManager-wwan
    openconnect
    spoofdpi
    vpnc
    wireguard-tools
    

    # Printing / CUPS / Drivers
    cups
    cups-pk-helper
    dymo-cups-drivers
    gutenprint-cups
    hplip
    libimobiledevice
    printer-driver-brlaser
    ptouch-driver
    system-config-printer-libs
    system-config-printer-udev

    # Security / Authentication
    audispd-plugins
    audit
    firewalld
    fprintd
    fprintd-pam
    git-credential-libsecret
    ksshaskpass
    pam_yubico
    pcsc-lite
    yubikey-manager

    # Performance
    ksmtuned
    # power-profiles-daemon
    scx-manager
    scx-scheds
    scx-tools
    scxctl
    thermald


    # System / Utilities
    acpica-tools
    adcli
    ansible
    bash-color-prompt
    bootc
    bpftool
    curl
    ddcutil
    evtest
    fuse
    fuse-common
    fuse-encfs
    fwupd
    htop
    inotify-tools
    iotop-c
    libcamera
    libcamera-gstreamer
    libcamera-ipa
    libcamera-tools
    libcamera-v4l2
    libimobiledevice
    libimobiledevice-utils
    libratbag-ratbagd
    libva-utils
    lm_sensors
    lshw
    man-db
    man-pages
    nvme-cli
    openssl
    perf
    plymouth
    plymouth-system-theme
    powerstat
    powertop
    rclone
    restic
    rsync
    setools-console
    shadow-utils
    smartmontools
    steam-devices
    stow
    strace
    switcheroo-control
    symlinks
    tcpdump
    tmux
    traceroute
    unzip
    usb_modeswitch
    uxplay
    vim
    whois
    wl-clipboard
    xdg-terminal-exec
    xdg-user-dirs
    xeyes
    xhost
    zstd

    # Fonts
    default-fonts
    default-fonts-core-emoji
    fira-code-fonts
    glibc-all-langpacks
    google-noto-cjk-fonts
    google-noto-color-emoji-fonts
    google-noto-emoji-fonts
    google-noto-fonts-all
    google-noto-sans-cjk-fonts
    google-noto-sans-fonts
    jetbrains-mono-fonts-all
    liberation-fonts
    mscore-fonts-all
    nerd-fonts
    rsms-inter-fonts

    # SMB
    samba
    samba-dcerpc
    samba-ldb-ldap-modules
    samba-winbind-clients
    samba-winbind-modules

    # Extra
    fastfetch
    firewall-config
    flatpak
    flatpak-spawn
    glx-utils
    tailscale
    # v4l2loopback

    # Input
    input-remapper

    # Codecs / Video / Images
    AtomicParsley
    libheif
    mozilla-openh264
    openh264
    perl-Image-ExifTool
    yt-dlp

    # Shell
    zsh

    # Dev tools
    clang
    clang-tools-extra
    cmake
    gcc
    git
    jq
    just
    kate
    lldb
    make
    mold
    ninja
    perl
    python3
    python3-pip
    ripgrep
    tokei
    uv
    wireshark

    # IME
    fcitx-qt5
    fcitx5-autostart
    fcitx5-configtool
    fcitx5-mozc
    fcitx5-qt
    imsettings
    kcm-fcitx5
    kcm-fcitx5  

    # KDE
    kdenetwork-filesharing
    kdeplasma-addons
    kdialog
    ksystemlog
    merkuro
    plasma-wallpapers-dynamic
    qt6-qtlocation

    # Caputre
    obs-studio
    # obs-vkcapture.i686
    # obs-vkcapture.x86_64 
    scrcpy

    # Games
    gamescope
    mangohud
    VK_hdr_layer

    # Virtualization
    libvirt
    qemu
    qemu-char-spice
    qemu-device-display-virtio-gpu
    qemu-device-display-virtio-vga
    qemu-device-usb-redirect
    qemu-img
    qemu-system-x86-core
    qemu-user-binfmt
    qemu-user-static
    virt-manager

    # Dictionaries
    mecab
    mecab-ipadic
    tesseract-langpack-jpn
    tio
)

dnf5 -y install "${packages[@]}"

packages_to_remove=(
    fedora-bookmarks
    fedora-chromium-config
    fedora-chromium-config-kde
    firefox
    firefox-langpacks
    kcharselect
    krfb
    krfb-libs
    podman-docker
    python-music2
)

dnf5 -y remove "${packages_to_remove[@]}"

dnf5 -y swap ffmpeg-free ffmpeg --allowerasing

echo "::endgroup::"

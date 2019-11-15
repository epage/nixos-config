{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # Version control / archiving
    git
    unzip zip unrar p7zip dtrx

    # Debugging / monitoring / analyzing
    htop iotop powertop iftop
    ltrace strace linuxPackages.perf
    pciutils lshw smartmontools usbutils

    # Linux shell utils
    pmutils psmisc which file binutils bc utillinuxCurses exfat dosfstools
    patchutils moreutils

    # Man pages
    man man-pages posix_man_pages stdman

    lsof
    mkpasswd
    nix-prefetch-scripts
    stdenv
    sudo
    sysstat
    tcpdump

    curl
    wget
  ];

  # Allow proprietary software (such as the NVIDIA drivers).
  nixpkgs.config.allowUnfree = true;
  nix = {
    trustedBinaryCaches = [
      http://cache.nixos.org
      http://hydra.nixos.org
      http://hydra.cryp.to
    ];
  };

  # automatic gc
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";
  # hardlink identical files to save space
  nix.autoOptimiseStore = true;

  documentation.enable = true;
  documentation.dev.enable = true;
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.man.enable = false;

  boot = {
    # See console messages during early boot.
    initrd.kernelModules = [ "fbcon" ];

    plymouth.enable = true;

    # Disable console blanking after being idle.
    kernelParams = [ "consoleblank=0" ];

    # Clean /tmp on boot
    cleanTmpDir = true;

    # Increase the amount of inotify watchers
    # Note that inotify watches consume 1kB on 64-bit machines.
    kernel.sysctl = {
      "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
      "fs.inotify.max_user_instances" =    1024;   # default:   128
      "fs.inotify.max_queued_events"  =   32768;   # default: 16384
    };
  };

  # Google nameservers
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set the timezone.
  time.timeZone = "America/Denver";

  # automatic updates every day
  system.autoUpgrade.enable = true;

  # Enable passwd and co.
  users.mutableUsers = true;

  services.fwupd.enable = true;

  # Disable displaying the NixOS manual in a virtual console.
  services.nixosManual.showManual = false;

  # Disable the infamous systemd screen/tmux killer
  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

  programs.command-not-found.enable = true;

  programs.bash.enableCompletion = true;

  programs.less.enable = true;

  programs.vim.defaultEditor = true;
}

# Ati has 477 GiB SSD. The below was 16GB swap setup was to avoid perf warnings about alignment.
#
# ```bash
# parted /dev/nvme0n1 -- mklabel gpt
# parted -a optimal /dev/nvme0n1 -- mkpart primary 512MiB -3.4%
# parted -a optimal /dev/nvme0n1 -- mkpart primary linux-swap -3.4% 100%
# parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
# parted /dev/nvme0n1 -- set 3 boot on
# mkfs.ext4 -L nixos /dev/nvme0n1p1
# mkswap -L swap /dev/nvme0n1p2
# mkfs.fat -F 32 -n boot /dev/nvme0n1p3
# ```

{ config, pkgs, ... }:

{
  imports =
    [
      ../users/epage.nix
      ../users/family.nix

      ../profiles/default.nix

      ../profiles/audio.nix
      ../profiles/avahi.nix
      ../profiles/bluetooth.nix
      ../profiles/desktop.nix
      ../profiles/printing.nix
      ../profiles/powermanagement.nix
      ../profiles/security.nix
      ../profiles/htpc.nix
    ];

  networking.hostName = "hoid";
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface  useDHCP will be mandatory in the future, so this generated config
  # replicates the default behavior.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.powertop.enable = true;
  services.upower.enable = true;
  networking.networkmanager.wifi.powersave = true;

  boot.kernelParams = [
    # Enable guc/huc firmware loading for intel gpu
    "i915.enable_guc=3"
    "i915.enable_psr=1"
  ];
  # HW video accel
  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    intel-media-driver
    vulkan-loader
  ];

  services.smartd.enable = true;
}


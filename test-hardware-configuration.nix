# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "aes_x86_64" "aesni_intel" "cryptd" "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e7a0efd4-35ba-4c6d-b5ff-85a3aaf1f1c0";
      fsType = "ext4";
      options = [ "relatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4834-E643";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/debc54f9-a039-4ed5-bbe2-9ead8212d679"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

{ config, pkgs, lib, ... }:

# For a more extreme case, see https://github.com/nixos/nixpkgs/tree/master/nixos/modules/profiles/hardened.nix
{
  environment.systemPackages = with pkgs; [
    opensc
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    yubioath-desktop
  ];

  security.apparmor.enable = true;
  security.protectKernelImage = true;
  security.hideProcessInformation = true;

  # Whitelist opensc's pkcs11 driver path for ssh-agent.
  # (normally all of /lib is allowed, but it isn't installed there)
  systemd.user.services.ssh-agent.serviceConfig = lib.mkForce {
    ExecStartPre = "${pkgs.coreutils}/bin/rm -f %t/ssh-agent";
    ExecStart =
      "${pkgs.openssh}/bin/ssh-agent " +
      "-P ${pkgs.opensc}/lib/opensc-pkcs11.so " +
      "-a %t/ssh-agent";
    StandardOutput = "null";
    Type = "forking";
    Restart = "on-failure";
    SuccessExitStatus = "0 2";
  };

  programs.ssh.startAgent = true;
  programs.gnupg.agent.enable = true;
  services.udev.packages = [ pkgs.libu2f-host pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  boot.kernelParams = [
    # Hardening: disable legacy virtual syscalls
    "vsyscall=none"
  ];
}

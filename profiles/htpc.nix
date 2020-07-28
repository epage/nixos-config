{ pkgs, ... }:

{
  services.xserver = {
    desktopManager.kodi.enable = true;
  };

  environment.systemPackages = with pkgs; [
  ];

  nixpkgs.config.kodi {
    enableControllers = true;
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };
}

{ config, lib, pkgs, ... }:
with lib;

let secrets = import ../secrets.nix;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.family = {
    description = "The Home Page$";
    isNormalUser = true;

    extraGroups = [
      "audio"
      "networkmanager"
      "users"
      "video"
    ];

    initialPassword = "family";
  };
}

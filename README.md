> nixos-config: system configuration for NixOS

[![Build Status](https://travis-ci.org/epage/nixos-config.svg?branch=master)](https://travis-ci.org/epage/nixos-config)

# Using

See also [nix-home](https://github.com/epage/nix-home)

## Installing

1. Add the channels:
```bash
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update nixos-hardware
sudo nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager
sudo nix-channel --update
```

2. Clone this repo
```bash
sudo nix-env -i git
cd /mnt/etc/nixos
sudo git clone https://github.com/epage/nixos-config.git
```

3. Setup `/mnt/etc/nixos/configuration.nix`
```nix
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nixos-config/machines/<machine>.nix
    ];

  system.stateVersion = # ...
}
```

4. Post-install
```bash
passwd  # Since we are using an initialPassword

sudo nix-channel --update nixos

sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update nixos-hardware
```

## Updating

```bash
cd /etc/nixos/nixos-config
sudo git pull
cd ..
sudo nixos-rebuild switch
```

# Implementation

- `machines/`: top-level files.
- `profiles/`: slices of configuration that can be pulled in.
- `hardware/`: Low-level hardware support (on top of the auto-generated `hardware-configuration. nix`)
- `users/`: Potential users for the various machines.

# Resources

- Based on [ghuntley/dotfiles-nixos](https://github.com/ghuntley/dotfiles-nixos)

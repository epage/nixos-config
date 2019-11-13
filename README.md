> nixos-config: system configuration for NixOS

[![Build Status](https://travis-ci.org/epage/nixos-config.svg?branch=master)](https://travis-ci.org/epage/nixos-config)

All you need in `configuration.nix`
```nix
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <path>/machines/<machine>.nix
    ];

  system.stateVersion = # ...
}
```

See also [nix-home](https://github.com/epage/nix-home)

# Implementation

- `machines/`: top-level files.
- `profiles/`: slices of configuration that can be pulled in.
- `hardware/`: Low-level hardware support (on top of the auto-generated `hardware-configuration. nix`)
- `users/`: Potential users for the various machines.

# Resources

- Based on [ghuntley/dotfiles-nixos](https://github.com/ghuntley/dotfiles-nixos)

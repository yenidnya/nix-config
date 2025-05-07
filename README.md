# Nix Configuration

[![Nix Unstable](https://img.shields.io/badge/NixOS-Unstable-blue.svg)](https://nixos.org/)
[![Made with Nix](https://img.shields.io/badge/Made_with-Nix-5277C3.svg?logo=nixos&logoColor=white)](https://nixos.org)
[![MIT License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

This repository contains my personal Nix configuration for both NixOS and macOS using home-manager.

## Overview

This configuration uses [Nix Flakes](https://nixos.wiki/wiki/Flakes) to manage dependencies and [Home Manager](https://github.com/nix-community/home-manager) to manage user environments across different systems. Nix provides a declarative, reproducible approach to system configuration, ensuring consistent environments across machines and eliminating "works on my machine" problems. This setup enables cross-platform consistency between NixOS and macOS with shared configurations and modular design.

## Installation

### Prerequisites

#### NixOS
NixOS users already have Nix installed. Just enable flakes:

```bash
# Edit configuration.nix to add:
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

#### macOS
Install Nix and enable flakes:

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Enable flakes (add to ~/.config/nix/nix.conf)
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Usage

### On NixOS

To build and switch to this configuration:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### On macOS

First, ensure Nix with flakes support is installed. Then:

```bash
nix --experimental-features 'nix-command flakes' run home-manager/master -- switch --flake .#yenidnya@macos
```

## Updating

To update all inputs:

```bash
nix flake update
```

To update a specific input:

```bash
nix flake lock --update-input nixpkgs
```

## License

This configuration is personal and provided as-is. Feel free to use it as inspiration for your own setup.

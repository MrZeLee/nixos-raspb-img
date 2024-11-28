# NixOS Raspberry Pi Configuration

## Overview

This repository contains a NixOS configuration for a Raspberry Pi 4, managed using Nix Flakes. The configuration provides a reproducible and declarative system setup.

## Prerequisites

- Raspberry Pi 4
- NixOS-compatible SD card or storage device
- Basic understanding of Nix and NixOS

## Features

- Declarative system configuration
- K3s Kubernetes cluster support
- Custom user configurations
- Modular system setup

## Installation

### 1. Prepare NixOS SD Card

```bash
# Clone this repository
git clone https://github.com/yourusername/nixos-raspb-img.git
cd nixos-raspb-img
```

### 2. Build and Switch Configuration

```bash
# Rebuild and switch to the new configuration
nixos-rebuild switch \
    --use-remote-sudo \
    --max-jobs 0 \
    --flake .#mrzelee
```

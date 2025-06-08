<p align="center"><img src="https://i.imgur.com/X5zKxvp.png" width=300px></p>

<p align="center">
  <a href="https://hyprland.org/">
    <img src="https://img.shields.io/static/v1?label=NIRI&message=latest&style=flat&logo=hyprland&colorA=24273A&colorB=8AADF4&logoColor=CAD3F5"/>
  </a>
   <a href="https://github.com/zemmsoares/awesome-rices">
    <img src="https://raw.githubusercontent.com/zemmsoares/awesome-rices/main/assets/awesome-rice-badge.svg" alt="awesome-rice-badge">
  </a>
  <a href="https://nixos.wiki/wiki/Flakes">
    <img src="https://img.shields.io/static/v1?label=Nix Flake&message=check&style=flat&logo=nixos&colorA=24273A&colorB=9173ff&logoColor=CAD3F5">
  </a>
</p>

<p align="center"><img src="/assets/1.png" width=600px></p>

<h2 align="center">革 | kaku</h2>

## 🌼 <samp>INSTALLATION (NixOS)</samp>

> Request:
> [NixOs](https://channels.nixos.org/nixos-24.05/latest-nixos-minimal-x86_64-linux.iso)

- Download ISO.

```bash
wget -O https://channels.nixos.org/nixos-24.05/latest-nixos-minimal-x86_64-linux.iso
```

- Boot Into the Installer.

- Switch to Root: `sudo -i`

- Partitions:

```bash
# Replace nvme with your disk partition
cfdisk /dev/nvme0n1
```

- Format Partitions:

```bash
mkfs.fat -F 32 -n EFI /dev/nvme0n1p1
mkfs.xfs -L NIXOS /dev/nvme0n1p2
```

- Mount Partitions:

```bash
mount /dev/disk/by-label/NIXOS /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/EFI /mnt/boot
```

- Enable nixFlakes

```bash
nix-shell -p nixVersions.stable git
```

- Clone my Dotfiles

```bash
git clone --depth 1 https://github.com/hazed/kaku /mnt/etc/nixos
```

- Generate Nix Hardware Settings:

```bash
sudo nixos-generate-config --dir /mnt/etc/nixos/hosts/nix --force

# Remove configuration.nix
rm -rf /mnt/etc/nixos/hosts/nix/configuration.nix
```

- Install Dotfiles Using Flake

```bash
mkdir -p /mnt/tmp
export TMPDIR=/mnt/tmp

# Move to folder
cd mnt/etc/nixos/

# Install
nixos-install --flake .#nix
```

- Reboot

### 🐙 <sup><sub><samp>Remember <strong>Default</strong> User & password are: nixos</samp></sub></sup>

- Change Default password for User.

```bash
passwd YourUser
```

- Install w/ Home-Manager the config

```bash
home-manager switch --flake 'github:hazed/kaku#hazed@nix'
```

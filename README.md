<p align="center"><img src="https://i.imgur.com/X5zKxvp.png" width=300px></p>

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
mount --mkdir /dev/disk/by-label/EFI /mnt/boot
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

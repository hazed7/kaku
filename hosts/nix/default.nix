{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

    # load modules on boot
    kernelModules = ["amdgpu" "v4l2loopback" "i2c-dev"];
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];

    kernelParams = [
      # Silent boot parameters
      "quiet"
      "loglevel=3"
      "systemd.show_status=no"
      "rd.systemd.show_status=no"
      "rd.udev.log-priority=2"
      # Host-specific AMD optimizations
      "amd_pstate=active"
      "amd_iommu"
      "mitigations=off"
      "nvme_core.default_ps_max_latency_us=0"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.nmi_watchdog" = 0;
    };

    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Output"
    '';

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = lib.mkForce 5;
    };

    initrd = {
      systemd.enable = false;
      availableKernelModules = [ "nvme" "xhci_pci" "ehci_pci" "ahci" "usb_storage" ];
      supportedFilesystems = [ "xfs" "vfat" ];
      kernelModules = [ "xfs" ];
    };

    plymouth.enable = false;
    consoleLogLevel = 3;

    # Clean tmp on boot
    tmp.cleanOnBoot = true;
  };

  networking.hostName = "nix";

  services = {
    # for SSD/NVME
    fstrim.enable = true;

    scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
  };
}

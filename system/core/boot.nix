{
  config,
  pkgs,
  ...
}: {
  boot = {
    bootspec.enable = true;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ntfs"];
    };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Silent boot
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "loglevel=2"
      "systemd.show_status=no"
      "rd.systemd.show_status=no"
      "rd.udev.log-priority=2"
    ];

    loader = {
      # systemd-boot on UEFI
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    # Disable plymouth for clean boot
    plymouth.enable = false;

    tmp.cleanOnBoot = true;
  };
  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}

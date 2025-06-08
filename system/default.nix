let
  desktop = [
    ./core/boot.nix
    ./core/default.nix

    ./hardware/graphics.nix
    ./hardware/fwupd.nix
    ./hardware/bluetooth.nix

    ./network/default.nix
    ./network/avahi.nix

    ./programs

    ./services
    ./services/greetd.nix
    ./services/pipewire.nix
  ];

in {
  inherit desktop;
}

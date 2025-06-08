{pkgs, ...}: {
  imports = [
    ./anyrun
    ./browsers/zen.nix
    ./gtk.nix
    ./media
  ];

  home.packages = with pkgs; [
    # messaging
    telegram-desktop

    # misc
    ps_mem
    pciutils
    nixos-icons
    colord
    ffmpegthumbnailer
    imagemagick
    cliphist
    nodejs
    nodePackages.pnpm
    bun

    fastfetch

    # gnome
    amberol
    cavalier
    (celluloid.override {youtubeSupport = true;})
    dconf-editor
    file-roller
    gnome-control-center
    gnome-text-editor
    # kooha
    loupe
    nautilus
    (papers.override {supportNautilus = true;})
    pwvucontrol
    resources

    inkscape
    # gimp
    # krita
    scrcpy

    swww
    ghostty
  ];
}

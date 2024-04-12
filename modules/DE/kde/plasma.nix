{...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  # Enable login manager
  services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";

  # KDE Plasma
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
}

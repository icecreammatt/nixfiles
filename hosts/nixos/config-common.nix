{pkgs, ...}: {
  time.timeZone = "America/Los_Angeles";

  users.users.matt = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmdl6XNEdT+EWf1IDRjHAygUIGpNCaBv9Qhm19cRCEm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGi7DLE/5v9yI2ZRPeKOftyngeNMvXOX/RDIyA0J3rtI matt@mini"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRq7YNesYqVvBoM/ncl8G6cUglY64jCOv3Lr5JtSaMQ matt@asahi"
    ];
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      fish
    ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    fish
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}

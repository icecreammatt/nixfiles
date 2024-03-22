{
  config,
  pkgs,
  lib,
  ...
}: let
  keyboard-dev-config = config.programs.keyboard-dev;
in {
  options = {
    programs.keyboard-dev = {
      enable = lib.mkOption {
        description = "enable tools for building and flashing qmk firmware";
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf keyboard-dev-config.enable {
    environment.systemPackages = with pkgs; [
      qmk
      avrdude
    ];
  };
}

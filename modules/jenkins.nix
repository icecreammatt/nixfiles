{
  config,
  pkgs,
  lib,
  ...
}: let
  jenkins-dev-config = config.programs.jenkins-dev;
in {
  options = {
    programs.jenkins-dev = {
      enable = lib.mkOption {
        description = "enable tools for working with jenkins code";
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf jenkins-dev-config.enable {
    environment.systemPackages = with pkgs; [
      jdk8
      jenkins
      jenkins-job-builder
      groovy
    ];
  };
}

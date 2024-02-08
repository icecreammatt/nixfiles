{lib, ...}: {
  options = {
    darkTheme = lib.mkOption {
      description = "enable dark mode theme";
      type = lib.types.bool;
      default = true;
    };

    gui = lib.mkOption {
      description = "enable gui packages";
      type = lib.types.bool;
      default = false;
    };

    largeStorage = lib.mkOption {
      description = "enable extra packages that take up space";
      type = lib.types.bool;
      default = false;
    };

    useHelixFork = lib.mkOption {
      description = "enable using helix fork";
      type = lib.types.bool;
      default = false;
    };
  };
}

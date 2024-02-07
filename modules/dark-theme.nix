{lib, ...}: {
  options.darkTheme = lib.mkOption {
    description = "enable dark mode theme";
    type = lib.types.bool;
    default = true;
  };
}

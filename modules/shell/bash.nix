{...}: {
  programs.fish = {
    enable = true;
    shellAliases = import ./aliases.nix;
  };
}

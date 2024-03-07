{
  pkgs,
  user,
  ...
}: {
  home.packages = with pkgs; [
    arduino
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["dialout"]; # needed for USB flashing
  };
}

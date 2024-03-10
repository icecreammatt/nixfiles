{
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [
    arduino
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["dialout"];
  };
}

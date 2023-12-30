{ ... }:


# This has to be run manually since
# rebuilding does not appear to restart the service
# >systemctl --user restart xremap
# >systemctl --user status xremap
{
    # Settings to enable xremap
    hardware.uinput.enable = true;
    users.groups.uinput.members = [ "matt" ];
    users.groups.input.members = [ "matt" ];

    services.xremap = {
    withKDE = true;
    userName = "matt";
    serviceMode = "user";
    debug = false;
    watch = false;
    config = {
      keymap = [
        {
          name = "Emacs commands globally";
          application = {
            only = ["/firefox/" "/dolphin/"];
          };
          remap = {
            "C-e" = "end";
            "C-a" = "home";
            "M-b" = { with_mark = "c-left"; };
            "M-f" = { with_mark = "c-right"; };
            "M-left" = { with_mark = "c-left"; };
            "M-right" = { with_mark = "c-right"; };
            "M-backspace" = { with_mark = "c-backspace"; };
            "M-delete" = ["c-right" "c-backspace"];
            "M-d" = "delete";
            "C-k" = ["Shift-end" "C-x"];
            "C-y" = ["C-v"];
            "SUPER-a" = "c-a";
            "SUPER-t" = "c-t";
            "SUPER-f" = "c-f";
            "SUPER-w" = "c-w";
            "SUPER-r" = "c-r";
            "SUPER-0" = "a-0";
            "SUPER-1" = "a-1";
            "SUPER-2" = "a-2";
            "SUPER-3" = "a-3";
            "SUPER-4" = "a-4";
            "SUPER-5" = "a-5";
            "SUPER-6" = "a-6";
            "SUPER-7" = "a-7";
            "SUPER-8" = "a-8";
            "SUPER-9" = "a-9";
          };
        }
      ];
      modmap = [  ];
    };
  };

}
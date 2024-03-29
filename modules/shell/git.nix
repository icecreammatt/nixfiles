{
  user,
  username,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "${username}";
    aliases = {
      lg1 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      lg = "!git lg1";
      ga = "add .";
      gcm = "git checkout main || git checkout master";
      co = "checkout";
      cob = "checkout -b";
      cp = "cherry-pick";
      ec = "config --global -e";
      wipe = "!git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      url = {
        "git@github.com:" = {
          insteadOf = [
            "https://github.com/"
          ];
        };
      };
      diff = {
        algorithm = "histogram";
      };
      core = {
        excludesfile = "/home/${user}/.gitignore_global";
        autocrlf = "input";
        trustctime = false;
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true; # use n and N to move between diff sections
        light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        syntax-theme = "Nord";
        side-by-side = "true";
        line-numbers = "true";
      };
      color = {ui = true;};
    };
  };
}

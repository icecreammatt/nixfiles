{ config, pkgs, ... }:

{
  programs.fish = { 
    enable = true;
    plugins = [{
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "6a844725a3f841abbbdf6495e2c6582a36be7a6b";
          sha256 = "sha256-eSNUqvKXTxcuvICxo8BmVWL1ESXQuU7VhOl7aONrhwM=";
        };
    }];

    #  export FZF_DEFAULT_OPTS="--preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} | less -f {}),f2:toggle-preview,ctrl-d:down,ctrl-u:up' --height 75% --layout=reverse --border --preview='bat --style=numbers --color=always {} || cat {} 2>/dev/null | head -500'"

    shellInit = ''
      fish_add_path $HOME/.nix-profile/bin
      fish_add_path $HOME/.npm-global/bin
      fish_add_path $HOME/bin
      export EDITOR=nvim
      export BAT_THEME=Dracula
      navi widget fish | source
    '';

    shellAliases = {
        "fzf-help" = "echo 'ctrl+option (f -> files, l -> log, s -> status, r -> history, v -> variables, e -> process id)'";
        "cd.." = "cd ..";
        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";
        "......." = "../../../../../..";
        dotfiles = "cd ~/nixfiles";
        nixfiles = "cd ~/nixfiles";
        Source = "cd ~/Source";
        flushdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
        amend="git commit --amend --no-edit";
        df = "df -h";
        diff = "diff -u";
        du = "du -h";
        dus = "du -sh";
        g = "git status -s";
        gui = "gitui";
        gau = "git add -u";
        gp = "git pull --rebase";
        gprom = "git pull --rebase origin/main || git pull --rebase origin/master";
        grom = "git rebase origin/main || git rebase origin/master";
        gpom = "git push -u origin main || git push -u origin master";
        grc = "git rebase --continue";
        gcm = "git checkout main || git checkout master || git checkout trunk";
        gss = "git stash save";
        gsp = "git stash pop";
        gsl = "git stash list";
        grh = "git reset --hard";
        gclean = "git remote prune origin; git branch --merged | grep -v -E \"(\*|master|main|dev|release|hotfix|trunk|prod)\" | xargs -n 1 git branch -d";
        gs = "git show";
        gf = "git fetch --all";
        gl = "git log";
        gb = "git branch -a";
        gcop = "git branch --sort=-committerdate | fzf --header 'Checkout Recent Branch' --preview \"git diff {1} --color=always\" --pointer=\"->\" | xargs git checkout";
        gco = "git co";
        gcob = "git cob";
        grv = "git remote -v";
        ga = "git add";
        gap = "git add -p";
        gd = "git diff -a";
        gdw = "git diff -w ";
        gdc = "git diff --cached";
        gdcw = "git diff --cached -w";
        ghb = "gh browse";
        ealias = "vi ~/nixfiles/fish.nix";
        hmbs = "pushd ~/.config/; home-manager build && home-manager switch; popd";
        hmb = "home-manager build";
        hms = "home-manager switch";
        l = "exa -lh";
        ll = "exa -lah";
        ls = "exa";
        la = "exa -la";
        cat="bat -p --theme Dracula";
        ehosts="sudo vi /etc/hosts";
        memory = "ps -A u | sort -k 4 -r | head";

        navi="navi --path ~/.navi/";

        tm="tmux -2 new -s '(basename '(pwd)')'";
        tma="tmux -2 attach -d -t";
        tmk="tmux kill-session -t";
        tml="tmux list-sessions";
        tmn="tmux new-session -t base";
        tmr="tmux rename-session -t";
        tmux="tmux -2";

        npmi="npm install";
        npmb="npm run build";
        npms="npm start";
        npmt="npm test";
        npml="npm run lint";

        vi = "nvim";
        vim = "nvim";
        vimrc = "vim ~/nixfiles/nvim.nix";
        sm = "merge";
        merge = "open -n -a \"Sublime Merge\" .";
        bane = "bane2";
        c = "code .";
    };
    shellAbbrs = {
        o = "open . &";
        ag = "rg";
    };
    functions = {
        gg = {
            description = "git fast commit";
            body = "git commit -m $argv[1]";
        };
        take = {
            description = "make directory and navigate to it";
            body = "mkdir $argv[1]; and cd $argv[1]";
        };
    };
  };
}

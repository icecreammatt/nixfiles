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

      # fish_add_path /etc/static/profiles/per-user/mcarrier/bin
      #navi widget fish | source

    shellInit = ''
      fish_add_path $HOME/bin
      fish_add_path $HOME/.npm-global/bin
      fish_add_path $HOME/.cargo/bin

      set fish_color_valid_path

      direnv hook fish | source
      export DIRENV_LOG_FORMAT=""

      export EDITOR=hx
      export BAT_THEME="Nord"
      export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,coverage/*,.next/*}"'
      export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=0 --padding=0"
      zoxide init fish | source
      export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
      export NNN_TMPFILE="~/.config/nnn/.lastd"
      export COLORTERM=truecolor

    '';

    shellAliases = {
        "fzf-help" = "echo 'ctrl+option (f -> files, l -> log, s -> status, r -> history, v -> variables, e -> process id)'";
        "cd.." = "cd ..";
        "cdr" = "ranger";
        "ran" = "ranger";
        f = "fish";
        ni = "pushd ~/nixfiles";
        strip = "pbpaste | pbcopy";
        clean = "pbpaste | pbcopy";
        jsonvalidate = "pbpaste | jq";
        dotfiles = "cd ~/nixfiles";
        nixfiles = "cd ~/nixfiles";
        pkgs = "$EDITOR ~/nixfiles/modules/common.nix";
        Source = "cd ~/Source";
        flushdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
        amend="git commit --amend --no-edit";
        diff = "diff -u";
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
        gcleanall = "git remote prune origin; git branch | grep -v -E \"(\*|master|main|dev|release|hotfix|trunk|prod)\" | xargs -n 1 git branch -D";
        gs = "git show";
        gf = "git fetch --all";
        gb = "git branch -a";
        gcop = "git branch --sort=-committerdate | fzf --header 'Checkout Recent Branch' --preview \"git diff {1} --color=always\" --pointer=\"->\" | xargs git checkout";
        gco = "git checkout";
        gcob = "git checkout -b";
        grv = "git remote -v";
        ga = "git add";
        gap = "git add -p";
        gd = "git diff -a";
        gdw = "git diff -w ";
        gdc = "git diff --cached";
        gdcw = "git diff --cached -w";
        ghb = "gh browse";
        lg = "lazygit";
        gl = "lazygit log";
        lad = "lazydocker";
        lac = "lazycli";
        x = "z";
        xi = "zi";
        pd = "popd";
        br = "broot -c:open_preview";
        lt = "broot -c:open_preview";

        ealias = "$EDITOR ~/nixfiles/modules/shell/fish.nix";
        hmbs = "pushd ~/.config/; home-manager build && home-manager switch; popd";
        hmb = "home-manager build";
        hms = "home-manager switch";
        tree = "exa --tree";
        l =  "exa -lh  --icons --group-directories-first --classify";
        ltree = "exa -lh  --icons --group-directories-first --classify --tree --color=always | bat";
        ll = "exa -lah --icons --group-directories-first --classify";
        la = "exa -la  --icons --group-directories-first --classify";
        ls = "exa";
        cat="bat -p";
        icat="wezterm imgcat";
        ehosts="sudo $EDITOR /etc/hosts";
        memory = "ps -A u | sort -k 4 -r | head";
        top="btm";
        htop="btm";

        port="lazycli -- 'lsof -i -P -n | grep -E \"(LISTEN|COMMAND)\"'";
        wine="lazycli -- 'lsof -i -P -n | grep -E \"(node|nginx)\" || echo \"No node or nginx servers running\"'";

        tm="tmux -2 new -s '(basename '(pwd)')'";
        tma="tmux -2 attach -d -t";
        tmk="tmux kill-session -t";
        tml="tmux list-sessions";
        tmn="tmux new-session -t base";
        tmr="tmux rename-session -t";
        tmux="tmux -2";

        rust="echo \"Use rr instead:\" && rust-script";
        rr="rust-script";
        ru="rust-script";
        cb="cargo build";
        cr="cargo run";

        kk="kubectl";

        npmi="npm install";
        npmb="npm run build";
        npms="npm start";
        npmt="npm test";
        npml="npm run lint";

        pnpmi="pnpm i";
        pnpmr="pnpm run";
        pnpmb="pnpm run build";
        pnpmt="pnpm test";
        pnpms="pnpm start";
        pnpml="pnpm run lint";

        xcd="cd (xplr --print-pwd-as-result)";
        xp="cd (xplr --print-pwd-as-result)";
        xd="cd (xplr --print-pwd-as-result)";

        he = "hx";
        vi = "$EDITOR";
        vim = "nvim";
        vimrc = "nvim ~/nixfiles/modules/editors/nvim.nix";
        hxrc = "$EDITOR ~/nixfiles/modules/editors/helix.nix";
        wzrc = "$EDITOR ~/nixfiles/modules/shell/wezterm/wezterm.lua";
        sm = "merge";
        merge = "open -n -a \"Sublime Merge\" .";
        bane = "bane2";
        c = "code .";
        note = "pushd ~/notes";
        nt = "pushd ~/notes";
        ntf = "pushd ~/notes && ske && popd";
        nts = "pushd ~/notes && rge && popd";

        dsw = "pushd ~/nixfiles && darwin-rebuild switch --flake . && popd";
        nsw = "pushd ~/nixfiles && sudo nixos-rebuild switch --flake . && popd";
        md2j = "pandoc --to jira | pbcopy";
    };
    shellAbbrs = {
        gbl = "git blame";
        jv = "pbpaste | jq";
        ghprv = "gh pr view --web";
        curl = "xh";
        o = "open . &";
        ag = "rg";
        he = "hx";
        kk="kubectl";
        df = "duf";
        du = "dust";
        g = "git status";
        gf = "git fetch --all";
        gp = "git pull --rebase";
        gpu = "git push";
        gpuf = "git push -f";
        gpuo = "git push -u origin";
        grc = "git rebase --continue";
        gco = "git checkout";
        gcob = "git checkout -b";
        dbt = "docker build -t temp .";
        drt = "docker run -it -p 3000:3000 temp";
        drti = "docker run -it -p 3000:3000 temp /bin/bash";
        nu = "ni && gp && nrs";
    };
    functions = {
        docker-run-image-td = {
          body = ''
            set port 3080
            if [ $argv[2] > 0 ];
              set port $argv[2]
            end

            echo "docker run -it -p $port:80 $argv[1]"
            docker run -it -p $port:80 $argv[1]
          '';
        };
        docker-run-image-td-bash = {
          body = ''
            set port 3080
            if [ $argv[2] > 0 ];
              set port $argv[2]
            end

            echo "docker run -it -p $port:80 $argv[1]" /bin/bash
            docker run -it -p $port:80 $argv[1] /bin/bash
          '';
        };
        nrs = {
          body = ''
            pushd ~/nixfiles

            uname -a | grep Darwin

            if [ $status = 0 ];
              darwin-rebuild switch --flake .
            else
              uname -a | grep NixOS
              if [ $status = 0 ];
                sudo nixos-rebuild switch --flake .
              else
                nix build .#asahiConfiguration.asahi.activationPackage
                ./result/activate
              end
            end

            popd
          '';
        };
        n = {
          body = ''
            # Rename this file to match the name of the function
            # e.g. ~/.config/fish/functions/n.fish
            # or, add the lines to the 'config.fish' file.

            # Block nesting of nnn in subshells
            if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
                echo "nnn is already running"
                return
            end

            # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
            # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
            # see. To cd on quit only on ^G, remove the "-x" from both lines below,
            # without changing the paths.
            if test -n "$XDG_CONFIG_HOME"
                set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
            else
                set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
            end

            # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
            # stty start undef
            # stty stop undef
            # stty lwrap undef
            # stty lnext undef

            # The command function allows one to alias this function to `nnn` without
            # making an infinitely recursive alias
            command nnn $argv

            if test -e $NNN_TMPFILE
                source $NNN_TMPFILE
                rm $NNN_TMPFILE
            end
          '';
        };
        ranger = {
            body = ''
                set tempfile (mktemp -t tmp.XXXXXX)
                command ranger --choosedir=$tempfile $argv
                set return_value $status

                if test -s $tempfile
                    set ranger_pwd (cat $tempfile)
                    if test -n $ranger_pwd -a -d $ranger_pwd
                        builtin cd -- $ranger_pwd
                    end
                end

                command rm -f -- $tempfile
                return $return_value

                [ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
            '';
        };
        clip = {
          body = ''
            cat $argv[1] | pbcopy
          '';
        };
        rge = {
            description = "search file contents and open in editor on line number";
            body = ''
              set x (sk --query "$argv[1]" --bind "ctrl-v:toggle-preview,ctrl-k:down" --ansi -c "rg --color=always --line-number \"{}\"" --preview="preview.sh -v {}" --preview-window=right:50%:visible)
              if [ $status = 0 ];
                set fileName (echo $x | cut -d: -f1)
                set lineNum (echo $x | cut -d: -f2)
                $EDITOR $fileName:$lineNum
              end
            '';
        };
        ske = {
            description = "search file names and open in editor";
            body = ''
              set x (sk --query "$argv[1]" --bind "ctrl-v:toggle-preview,ctrl-k:down" --ansi --preview="preview.sh -v {}" --preview-window=right:50%:visible)
              if [ $status = 0 ];
                $EDITOR "$x"
              end
            '';
        };
        fish_greeting = {
          description = "welcome message";
          body = "";
        };
        gg = {
            description = "git fast commit";
            body = "git commit -m $argv[1]";
        };
        ggn = {
            description = "git fast commit, no verify";
            body = "git commit -m $argv[1] --no-verify";
        };
        take = {
            description = "make directory and navigate to it";
            body = "mkdir -p $argv[1]; and cd $argv[1]";
        };
        gc = {
            description = "clone repo and navigate to it";
            body = ''
              git clone $argv[1]; 
              set repoPath (string split '/' $argv[1])
              set repoName (string split '.' $repoPath[-1])
              set length (count $repoName)
              if [ $length = 1 ];
                cd $repoName
              else
                cd $repoName[-2]
              end
            '';
        };
        fish_prompt = {
          body = ''
            set -l last_status $status

            prompt_login

            # echo -n ':'

            # PWD
            # set_color $fish_color_cwd
            printf (prompt_pwd)
            set_color normal

            set -q __fish_git_prompt_showdirtystate
            or set -g __fish_git_prompt_showdirtystate 1
            set -q __fish_git_prompt_showuntrackedfiles
            or set -g __fish_git_prompt_showuntrackedfiles 1
            set -q __fish_git_prompt_showcolorhints
            or set -g __fish_git_prompt_showcolorhints 1
            set -q __fish_git_prompt_color_untrackedfiles
            or set -g __fish_git_prompt_color_untrackedfiles yellow
            set -q __fish_git_prompt_char_untrackedfiles
            or set -g __fish_git_prompt_char_untrackedfiles '?'
            set -q __fish_git_prompt_color_invalidstate
            or set -g __fish_git_prompt_color_invalidstate red
            set -q __fish_git_prompt_char_invalidstate
            or set -g __fish_git_prompt_char_invalidstate '!'
            set -q __fish_git_prompt_color_dirtystate
            or set -g __fish_git_prompt_color_dirtystate blue
            set -q __fish_git_prompt_char_dirtystate
            or set -g __fish_git_prompt_char_dirtystate '*'
            set -q __fish_git_prompt_char_stagedstate
            or set -g __fish_git_prompt_char_stagedstate '✚'
            set -q __fish_git_prompt_color_cleanstate
            or set -g __fish_git_prompt_color_cleanstate green
            set -q __fish_git_prompt_char_cleanstate
            or set -g __fish_git_prompt_char_cleanstate '✓'
            set -q __fish_git_prompt_color_stagedstate
            or set -g __fish_git_prompt_color_stagedstate yellow
            set -q __fish_git_prompt_color_branch_dirty
            or set -g __fish_git_prompt_color_branch_dirty red
            set -q __fish_git_prompt_color_branch_staged
            or set -g __fish_git_prompt_color_branch_staged yellow
            set -q __fish_git_prompt_color_branch
            or set -g __fish_git_prompt_color_branch green
            set -q __fish_git_prompt_char_stateseparator
            or set -g __fish_git_prompt_char_stateseparator ""
            fish_vcs_prompt '(%s)'

            if not test $last_status -eq 0
                set_color $fish_color_error
            end

            if test -f .envrc
                set prompt_symbol (cat .envrc | grep symbol | cut -d "=" -f 2-)
                printf "$prompt_symbol =>"
            else
                printf ">"
            end

            set_color normal
          '';
        };
        npmGlobalFix = {
            description = "fix npm bin directory linking";
            body = "npm config set prefix '~/.npm-global'";
        };
    };
  };
}

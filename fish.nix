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
    shellInit = ''
      fish_add_path $HOME/.npm-global/bin
      export EDITOR=nvim
    '';
	shellAliases = {
		amend="git commit --amend --no-edit";
		df = "df -h";
		diff = "diff -u";
		du = "du -h";
		dus = "du -sh";
		g = "git status -s";
		gau = "git add -u";
		gp = "git pull --rebase";
		gprom = "git pull --rebase origin/main || git pull --rebase origin/master";
        grom = "git rebase origin/main || git rebase origin/master"

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
		gco = "git co";
		gcob = "git cob";
		grv = "git remote -v";
		ga = "git add";
		gap = "git add -p";
		gd = "git diff -a";
		gdw = "git difftool -y --extcmd icdiff -w | less";
		gdc = "git difftool -y --extcmd icdiff --cached | less";
		gdcw = "git difftool -y --extcmd icdiff --cached -w | less";
		ealias = "vi ~/nixfiles/fish.nix";
		hmbs = "home-manager build && home-manager switch";
		l = "exa -lh";
		ll = "exa -lah";
		ls = "exa";
        la = "exa -la";
		cat="bat -p";
		ehosts="sudo vi /etc/hosts";
		memory = "ps -A u | sort -k 4 -r | head";

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

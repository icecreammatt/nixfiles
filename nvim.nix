{ config, pkgs, lib, vimUtils, ... }:
 
# let
#   # installs a vim plugin from git with a given tag / branch
#   pluginGit = ref: repo: vimUtils.buildVimPluginFrom2Nix {
#     pname = "${lib.strings.sanitizeDerivationName repo}";
#     version = ref;
#     src = builtins.fetchGit {
#       url = "https://github.com/${repo}.git";
#       ref = ref;
#     };
#   };

# plugin = pluginGit "HEAD";

# in {
{
    programs.neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
            nerdtree
            vim-nix
            auto-pairs
            fugitive
            fzf-vim
            fzfWrapper
            surround
            base16-vim
            vim-easymotion
            #coc-tsserver
            neoterm
            commentary
        ];

        extraConfig = ''

            let mapleader = ","

            noremap H ^
            noremap L $

            nnoremap <space> <C-d>
            nnoremap <leader><space> <C-u>

            " Allows tab to indent and switch between tabs
            vnoremap <Tab> >gv
            vnoremap <S-Tab> <gv
            nnoremap <S-TAB> :bprev<CR>
            nnoremap <TAB> :bnext<CR>

            noremap <c-s> :w<CR>
            imap <c-s> <Esc>:w<CR>a
            imap <c-s> <Esc><c-s>

            map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

            map <leader>b :NERDTreeToggle<CR>
            map <leader>f :NERDTreeFind<CR>

            map <leader>n :set number!<CR>
            map <leader>e :s/&/\r&/g<CR>

            let NERDTreeIgnore=['\.pyc$', '\.o$', '\~$', 'node_modules$', 'build$', '\.git', '\.svn']

            "{ NERDTree Settings
              autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
              autocmd StdinReadPre * let s:std_in=1
              autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
            "}

            set listchars=tab:│\ ,nbsp:·
            set list " View whitespace

            nnoremap <c-p> :FZF<CR>


            map <leader>l <Plug>(easymotion-lineforward)
            map <leader>j <Plug>(easymotion-j)
            map <leader>k <Plug>(easymotion-k)
            map <leader>h <Plug>(easymotion-linebackward)

            "{ Easymotion
            let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
            map / <Plug>(easymotion-sn)
            omap / <Plug>(easymotion-tn)
            map n <Plug>(easymotion-next)
            map N <Plug>(easymotion-prev)
            "}

            let base16colorspace=256  " Access colors present in 256 colorspace
            set nocompatible            " disable compatibility to old-time vi
            set showmatch               " show matching 
            set ignorecase              " case insensitive 
            set mouse=v                 " middle-click paste with 
            set hlsearch                " highlight search 
            set incsearch               " incremental search
            set tabstop=4               " number of columns occupied by a tab 
            set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
            set expandtab               " converts tabs to white space
            set shiftwidth=4            " width for autoindents
            set autoindent              " indent a new line the same amount as the line just typed
            set number                  " add line numbers
            set wildmode=longest,list   " get bash-like tab completions
            " set cc=80                  " set an 80 column border for good coding style
            filetype plugin indent on   "allow auto-indenting depending on file type
            syntax on                   " syntax highlighting
            set mouse=a                 " enable mouse click
            set clipboard=unnamedplus   " using system clipboard
            filetype plugin on
            set cursorline              " highlight current cursorline
            set ttyfast                 " Speed up scrolling in Vim
            " set spell                 " enable spell check (may need to download language package)
            " set noswapfile            " disable creating swap file
            set backupdir=~/.cache/vim " Directory to store backup files.

            " color schemes
            " if (has(“termguicolors”))
            "     set termguicolors
            " endif

            syntax enable

            " colorscheme evening 
            " colorscheme dracula
            
            " open new split panes to right and below
            set splitright
            set splitbelow

            " move line or visually selected block - alt+j/k
            inoremap <A-j> <Esc>:m .+1<CR>==gi
            inoremap <A-k> <Esc>:m .-2<CR>==gi
            vnoremap <A-j> :m '>+1<CR>gv=gv
            vnoremap <A-k> :m '<-2<CR>gv=gv" move split panes to left/bottom/top/right
            nnoremap <A-h> <C-W>H
            nnoremap <A-j> <C-W>J
            nnoremap <A-k> <C-W>K
            nnoremap <A-l> <C-W>L" move between panes to left/bottom/top/right
            nnoremap <C-h> <C-w>h
            nnoremap <C-j> <C-w>j
            nnoremap <C-k> <C-w>k
            nnoremap <C-l> <C-w>l

            " Press i to enter insert mode, and ii to exit insert mode.
            :inoremap ii <Esc>
            :inoremap jk <Esc>
            :inoremap kj <Esc>
            :vnoremap jk <Esc>
            :vnoremap kj <Esc>


            " open file in a text by placing text and gf
            nnoremap gf :vert winc f<cr>" copies filepath to clipboard by pressing yf
            :nnoremap <silent> yf :let @+=expand('%:p')<CR>
            " copies pwd to clipboard: command yd
            :nnoremap <silent> yd :let @+=expand('%:p:h')<CR>" Vim jump to the last position when reopening a file
            if has("autocmd")
            au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
            endif

            function! TmuxMove(direction)
                    let wnr = winnr()
                    silent! execute 'wincmd ' . a:direction
                    " If the winnr is still the same after we moved, it is the last pane
                    if wnr == winnr()
                            call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
                    end
            endfunction

            nnoremap <silent> <C-Left> :call TmuxMove('h')<cr>
            nnoremap <silent> <C-Down> :call TmuxMove('j')<cr>
            nnoremap <silent> <C-Up> :call TmuxMove('k')<cr>
            nnoremap <silent> <C-Right> :call TmuxMove('l')<cr>

            nnoremap <silent> <C-h> :call TmuxMove('h')<cr>
            nnoremap <silent> <C-j> :call TmuxMove('j')<cr>
            nnoremap <silent> <C-k> :call TmuxMove('k')<cr>
            nnoremap <silent> <C-l> :call TmuxMove('l')<cr>



        '';
    };
}

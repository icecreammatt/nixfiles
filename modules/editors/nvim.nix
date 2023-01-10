{ config, pkgs, lib, vimUtils, ... }:

# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono/Ligatures/Thin/complete ttf
 
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

# tokyonight-nvim

# in {
{
  programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
          commentary
          fugitive
          fzf-lsp-nvim
          fzf-vim
          fzfWrapper
          gitgutter
          indentLine
          lualine-nvim
          neoterm
          nvim-compe
          nvim-lspconfig
          nvim-tree-lua
          nvim-web-devicons
          surround
          vim-devicons
          vim-easymotion
          vim-fugitive
          vim-nix
          vim-svelte
          plenary-nvim
          # Eyecandy
          bufferline-nvim
          nvim_context_vt
          nvim-treesitter
          nvim-treesitter-context
      ];

      extraConfig = ''
          luafile ~/.config/nvim/settings.lua
          " luafile ~/.config/nvim/nvim-treesitter.config
          "autocmd ColorScheme * highlight highlight NvimTreeBg guibg=#2B4252
          "autocmd FileType NvimTree setlocal winhighlight=Normal:NvimTreeBg

          set scrolloff=20

          let g:fzf_history_dir = '~/.fzf-history'

          " lua << EOF
          " vim.defer_fn(function()
          "   vim.cmd [[
          "     luafile ~/.config/nvim/lua/lsp.lua
          "   ]]
          " end, 70)
          " EOF

          " noremap H ^
          " noremap L $

          nnoremap <space> <C-d>
          nnoremap <leader><space> <C-u>

          " Allows tab to indent and switch between tabs
          vnoremap <c-Tab> >gv
          vnoremap <c-S-Tab> <gv
          nnoremap <c-S-TAB> :bprev<CR>
          nnoremap <c-TAB> :bnext<CR>

          noremap <c-s> :w<CR>
          imap <c-s> <Esc>:w<CR>a
          imap <c-s> <Esc><c-s>

          nmap <c-_> :Commentary<CR>
          vmap <c-_> :Commentary<CR>
          imap <c-_> <Esc>:Commentary<CR>i

          map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

          map <leader>d :NvimTreeToggle<CR>

          map <leader>f :Rg!<CR>
          map <c-f> :Rg!<CR>

          map <leader>r :NvimTreeFindFile<CR>
          map <leader>g :GFiles<CR>

          map <leader>o :Buffers<CR>
          map <leader><Tab> :Buffers<CR>

          nnoremap <c-p> :Files<CR>
          map <leader>p :Command<CR>

          map <leader>n :set number!<CR>
          map <leader>e :s/&/\r&/g<CR>

          set listchars=tab:│\ ,nbsp:·
          set list " View whitespace
          set laststatus=3
          highlight WinSeparator guibg=None
          highlight VertSplit cterm=NONE
          highlight EndOfBuffer ctermfg=black ctermbg=NONE

          map <leader>l <Plug>(easymotion-lineforward)
          map <leader>j <Plug>(easymotion-j)
          map <leader>k <Plug>(easymotion-k)
          map <leader>h <Plug>(easymotion-linebackward)

          let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
          map / <Plug>(easymotion-sn)
          omap / <Plug>(easymotion-tn)
          map n <Plug>(easymotion-next)
          map N <Plug>(easymotion-prev)

          let base16colorspace=256  " Access colors present in 256 colorspace
          set nocompatible            " disable compatibility to old-time vi
          set showmatch               " show matching 
          set mouse=v                 " middle-click paste with 
          set hlsearch                " highlight search 
          set incsearch               " incremental search
          " set expandtab               " converts tabs to white space
          set noexpandtab
          set tabstop=4 " enable tabs
          set shiftwidth=0            " width for autoindents
          set autoindent              " indent a new line the same amount as the line just typed
          " set number                  " add line numbers
          set wildmode=longest,list   " get bash-like tab completions
          " set cc=80                  " set an 80 column border for good coding style
          " filetype plugin indent on   "allow auto-indenting depending on file type
          " set mouse=a                 " enable mouse click
          " filetype plugin on

          set ttyfast                 " Speed up scrolling in Vim
          " set spell                 " enable spell check (may need to download language package)
          " set noswapfile            " disable creating swap file
          set backupdir=~/.cache/vim " Directory to store backup files.

          " color schemes
          " if (has(“termguicolors”))
          "     set termguicolors
          " endif

          hi CursorLine cterm=NONE ctermbg=Black ctermfg=NONE
          hi SignColumn cterm=NONE ctermbg=NONE ctermfg=NONE

          highlight GitGutterAdd    guifg=#009900 ctermfg=2
          highlight GitGutterChange guifg=#bbbb00 ctermfg=3
          highlight GitGutterDelete guifg=#ff2222 ctermfg=1

          "syntax on                   " syntax highlighting
          "syntax enable

          " colorscheme evening 
          " colorscheme dracula
          
          " move line or visually selected block - alt+j/k
          " inoremap <A-j> <Esc>:m .+1<CR>==gi
          " inoremap <A-k> <Esc>:m .-2<CR>==gi
          " vnoremap <A-j> :m '>+1<CR>gv=gv
          " vnoremap <A-k> :m '<-2<CR>gv=gv " move split panes to left/bottom/top/right
          nnoremap <A-h> <C-W>H
          nnoremap <A-j> <C-W>J
          nnoremap <A-k> <C-W>K
          nnoremap <A-l> <C-W>L" move between panes to left/bottom/top/right
          nnoremap <C-h> <C-w>h
          nnoremap <C-j> <C-w>j
          nnoremap <C-k> <C-w>k
          nnoremap <C-l> <C-w>l

          " Press i to enter insert mode, and ii to exit insert mode.
          " :inoremap ii <Esc>
          " :inoremap jk <Esc>
          " :inoremap kj <Esc>
          " :vnoremap jk <Esc>
          " :vnoremap kj <Esc>

          " https://github.com/bunnyfly/dotfiles/blob/master/config/nvim/init.vim
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " Colemak-Vim Mappings
          "
          " The idea is to use HNEI as arrows – keeping the traditional Vim homerow style – and changing as
          " little else as possible. This means JKL are free to use and NEI need new keys.
          " - k/K is the new n/N.
          " - s/S is the new i/I ["inSert"].
          " - j/J is the new e/E ["Jump" to EOW].
          " - l/L skip to the beginning and end of lines. Much more intuitive than ^/$.
          " - Ctrl-l joins lines, making l/L the veritable "Line" key.
          " - r replaces i as the "inneR" modifier [e.g. "diw" becomes "drw"].
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " HNEI arrows. (Swapping 'gn'/'ge' and 'n'/'e'.)
            noremap n gj|noremap e gk|noremap i l|noremap gn j|noremap ge k
          " in(S)ert. The default s/S is synonymous with cl/cc and is not very useful.
            noremap s i|noremap S I
          " Repeat search.
            noremap k n|noremap K N
          " BOL/EOL/Join.
            noremap l ^|noremap L $|noremap <C-l> J
          " _r_ = inneR text objects.
            onoremap r i
          " EOW.
            noremap j e|noremap J E

           """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " Other Colemak Arrow-Based Mappings
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " Switch tabs with Ctrl.
          " nnoremap <C-h> <C-PageUp>|nnoremap <C-i> <C-PageDown>
          " Switch panes with Shift.
          " noremap H <C-w>h|noremap I <C-w>l|noremap N <C-w>j|noremap E <C-w>k
          " Moving windows around.
          " noremap <C-w>N <C-w>J|noremap <C-w>E <C-w>K|noremap <C-w>I <C-w>L
          " High/Low. Mid remains `M` since <C-m> is unfortunately interpreted as <CR>.
            noremap <C-e> H|noremap <C-n> L
          " Scroll screen up/down.
            noremap zn <C-y>|noremap ze <C-e>
          " Jumplist and changelist.
            nnoremap gh <C-o>|nnoremap gi <C-i>|nnoremap gH g;|nnoremap gI g,           


          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " General Mappings
          """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          " The best!
          " noremap ; :|noremap : ;
          " Sane redo.
            noremap U <C-r>
          " Y consistent with C and D.
            noremap Y y$
          " +/- increment and decrement.
          " nnoremap + <C-a>|nnoremap - <C-x>
          " Jump to exact mark location with ' instead of line.
          " noremap ' `|noremap ` '
          " Switch between most recent buffer with backspace
            nnoremap <BS> <C-^>
          " zT/zB is like zt/zb, but scrolls to the top/bottom quarter of the screen.
            nnoremap <expr> zT 'zt' . winheight(0)/4 . '<C-y>'
            nnoremap <expr> zB 'zb' . winheight(0)/4 . '<C-e>'
          " Auto-bracket.
            inoremap {<CR> {<CR>}<Esc>O

          " open file in a text by placing text and gf (this places file under cursor into buffer)
          " nnoremap gf :vert winc f<cr>" copies filepath to clipboard by pressing yf
          :nnoremap <silent> yf :let @+=expand('%:p')<CR>
          " copies pwd to clipboard: command yd
          :nnoremap <silent> yd :let @+=expand('%:p:h')<CR>" Vim jump to the last position when reopening a file
          if has("autocmd")
          au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
              \| exe "normal! g'\"" | endif
          endif

          " Fullscreen current buffer
          "map <leader>z :tabe %<CR>
          "map <leader>Z :q<CR>
          map <leader>a :call ToggleFullScreenBuffer()<CR>
          map <leader>z :call ToggleFullScreenBuffer()<CR>

          let g:fullScreen = 0
          function! ToggleFullScreenBuffer()
            if g:fullScreen
                :q
                let g:fullScreen = 0
            else
                :tabe %
                let g:fullScreen = 1
            endif
          endfunction

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
          " Resize windows using alt hjkl
          nnoremap <M-h> :vertical resize -1<cr>
          nnoremap <M-j> :res -1<cr>
          nnoremap <M-k> :res +1<cr>
          nnoremap <M-l> :vertical resize +1<cr>

        '';
      };

    home.file.".config/nvim/settings.lua".source = ./nvim/init.lua;
    # home.file.".config/nvim/lualine.lua".source = ./nvim/lualine.lua;

}

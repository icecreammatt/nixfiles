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

          let g:fzf_history_dir = '~/.fzf-history'

          " lua << EOF
          " vim.defer_fn(function()
          "   vim.cmd [[
          "     luafile ~/.config/nvim/lua/lsp.lua
          "   ]]
          " end, 70)
          " EOF

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

          " open file in a text by placing text and gf (this places file under cursor into buffer)
          " nnoremap gf :vert winc f<cr>" copies filepath to clipboard by pressing yf
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

    home.file.".config/nvim/settings.lua".source = ./nvim/init.lua;
    # home.file.".config/nvim/lualine.lua".source = ./nvim/lualine.lua;

}

local o = vim.opt
local g = vim.g

-- o.termguicolors = true

-- o.syntax = true
o.cursorline = true
o.ignorecase = true         -- case insenstive search
o.tabstop = 4               -- number of columns occupied by a tab 
o.softtabstop = 4           -- see multiple spaces as tabstops so <BS> does the right thing

o.clipboard = 'unnamedplus' --  using system clipboard

g.mapleader = ','

-- open new split panes to right and below
o.splitright = true
o.splitbelow = true

-- Nicer UI settings
-- o.cursorline = true
-- o.relativenumber = true
-- o.number = true

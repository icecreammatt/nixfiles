local o = vim.opt
local g = vim.g

-- o.termguicolors = true

vim.o.completeopt = "menuone,noselect"


-- bufferline settings
require("bufferline").setup{
    options = {
        indicator = {
            style = 'underline'
        },
        termguicolors = true,
        diagnostics = "nvim_lsp",
        separator_style = {"", ""},
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end,
        -- custom_areas = {
        --     right = function()
        --         local result = {}
        --         local seve = vim.diagnostic.severity
        --         local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
        --         local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
        --         local info = #vim.diagnostic.get(0, {severity = seve.INFO})
        --         local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

        --         if error ~= 0 then
        --             table.insert(result, {text = "  " .. error, fg = "#EC5241"})
        --         end

        --         if warning ~= 0 then
        --             table.insert(result, {text = "  " .. warning, fg = "#EFB839"})
        --         end

        --         if hint ~= 0 then
        --             table.insert(result, {text = "  " .. hint, fg = "#A3BA5E"})
        --         end

        --         if info ~= 0 then
        --             table.insert(result, {text = "  " .. info, fg = "#7EA9A7"})
        --         end
        --         return result
        --     end
        -- }
    }
}

require('nvim-treesitter.configs').setup {
  highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require'lspconfig'.rnix.setup{}
require'lspconfig'.svelte.setup{}

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme dracula]]
-- o.background = "dark"

require'compe'.setup {
    enable = true;
    autocomplete = true;
    min_length = 1;
    preselect = 'enable';
    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        nvim_lua = true;
        tags = true;
        treesitter = true;
    }
}

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    else
        return t "<S-Tab>"
    end
end


vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})

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

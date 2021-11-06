-- Load plugins
require('plugins')

vim.opt.termguicolors = true

-- Lualine for statusline
require('vile-lualine')

-- Everforest colorscheme
vim.cmd("colorscheme everforest")
vim.g.everforest_transparent_background = 1

-- Coq autocompletion
vim.g.coq_settings = { auto_start = 'shut-up' }
require('coq')

-- Rust-analyzer options
require'lspconfig'.rust_analyzer.setup{}
rust = require('rust-tools')
rust.setup({
    tools = {
        hover_with_actions = true,
        hover_actions = {
            auto_focus = true
        }
    }
})


-- Devicons for icons in nvimtree and bufferline
require'nvim-web-devicons'.setup {
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            name = "Zsh"
        }
    };
    default = true;
}

-- Telescope for fuzzyfinder
require('telescope').setup{}

require('gitsigns').setup{}

-- Treesitter for syntax highlighting
vim.g.indent_blankline_use_treesitter = true
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
}

vim.cmd [[highlight indent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight indent2 guifg=#ffffff gui=nocombine]]

-- Indentation guides
require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"},
}

-- Nvim-tree setup
require'nvim-tree'.setup {
    update_focused_file = {
        enable = true,
    }
}

require('lightspeed').setup {}

-- Bufferline for buffer tabs
require("bufferline").setup{}

-- General 
require('core.settings')
require('core.keybinds')

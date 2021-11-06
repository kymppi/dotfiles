-- Telescope keybinds
vim.api.nvim_set_keymap('','ff','<cmd>Telescope find_files<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','fg','<cmd>Telescope live_grep<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','fb','<cmd>Telescope buffers<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','fh','<cmd>Telescope help_tags<CR>',{ noremap = true })

-- NvimTree keybinds
vim.api.nvim_set_keymap('','<C-n>','<cmd>NvimTreeToggle<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','nr','<cmd>NvimTreeRefresh<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','nn','<cmd>NvimTreeFindFile<CR>',{ noremap = true })
vim.api.nvim_set_keymap('t','<Esc>','<C-\\><C-n>',{ noremap = true })

-- Bufferline keybinds
vim.api.nvim_set_keymap('',']b','<cmd>BufferLineCycleNext<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','[b','<cmd>BufferLineCyclePrev<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','be','<cmd>BufferLineSortByExtension<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('','bd','<cmd>BufferLineSortByDirectory<CR>',{ noremap = true, silent = true })

-- Lsp keybinds
vim.api.nvim_set_keymap('','<leader><space>','<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })

-- Rust related keybinds
vim.api.nvim_set_keymap('','<leader>rh','<cmd>RustHoverRange<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','<leader>ru','<cmd>RustMoveItemUp<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','<leader>rd','<cmd>RustMoveItemDown<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','<leader>re','<cmd>RustExpandMacro<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','<leader>rr','<cmd>RustRunnables<CR>',{ noremap = true })
vim.api.nvim_set_keymap('','<leader>rp','<cmd>RustParentModule<CR>',{ noremap = true })


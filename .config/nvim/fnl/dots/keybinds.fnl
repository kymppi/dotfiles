(module dots.keybinds
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(defn map [mode lhs rhs ?opts]
  (nvim.set_keymap mode lhs rhs (or ?opts {:noremap true})))

(map :n "<leader>ff" "<cmd>Telescope find_files<CR>")
(map :n "<leader>fg" "<cmd>Telescope live_grep<CR>")
(map :n "<leader>fb" "<cmd>Telescope buffers<CR>")
(map :n "<leader>fh" "<cmd>Telescope help_tags<CR>")
(map :t "<Esc>" "<C-\\><C-n>")

;; Bufferline keybinds
(map :n "bl" "<cmd>BufferLineCycleNext<CR>")
(map :n "bk" "<cmd>BufferLineCyclePrev<CR>")
(map :n "bf" "<cmd>BufferLinePick<CR>")
(map :n "bö" "<cmd>BufferLineMoveNext<CR>")
(map :n "bj" "<cmd>BufferLineMovePrev<CR>")
(map :n "be" "<cmd>BufferLineSortByExtension<CR>" {:noremap true :silent true})
(map :n "bd" "<cmd>BufferLineSortByDirectory<CR>" {:noremap true :silent true})

;; Lsp keybinds
(map :n "<leader><space>" "<cmd>lua vim.lsp.buf.hover()<CR>")
(map :n "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<CR>")

;; Rust related keybinds
(map :n "<leader>rs" "<cmd>RustStartStandaloneServerForBuffer<CR>")
(map :n "<leader>rh" "<cmd>RustHoverRange<CR>")
(map :n "<leader>ra" "<cmd>RustCodeAction<CR>")
(map :n "<leader>ru" "<cmd>RustMoveItemUp<CR>")
(map :n "<leader>rd" "<cmd>RustMoveItemDown<CR>")
(map :n "<leader>re" "<cmd>RustExpandMacro<CR>")
(map :n "<leader>rr" "<cmd>RustRunnables<CR>")
(map :n "<leader>rp" "<cmd>RustParentModule<CR>")

;; Gitsigns
(map :n "<leader>hs" ":Gitsigns stage_hunk<CR>")
(map :v "<leader>hs" ":Gitsigns stage_hunk<CR>")
(map :n "<leader>hr" ":Gitsigns reset_hunk<CR>")
(map :v "<leader>hr" ":Gitsigns reset_hunk<CR>")
(map :n "<leader>hS" "<cmd>Gitsigns stage_buffer<CR>")
(map :n "<leader>hu" "<cmd>Gitsigns undo_stage_hunk<CR>")
(map :n "<leader>hR" "<cmd>Gitsigns reset_buffer<CR>")
(map :n "<leader>hp" "<cmd>Gitsigns preview_hunk<CR>")
(map :n "<leader>hb" "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>")
(map :n "<leader>tb" "<cmd>Gitsigns toggle_current_line_blame<CR>")
(map :n "<leader>hd" "<cmd>Gitsigns diffthis<CR>")
(map :n "<leader>hD" "<cmd>lua require'gitsigns'.diffthis('~')<CR>")
(map :n "<leader>td" "<cmd>Gitsigns toggle_deleted<CR>")

(map :n "<leader>n" ":Neogit<CR>")

(map :n "<leader>rf" ":RustFmt<CR>")

;; Trouble.nvim keybinds
(map :n "<leader>xx"  "<cmd>Trouble<cr>" {:noremap true :silent true})
(map :n "<leader>xw"  "<cmd>Trouble lsp_workspace_diagnostics<cr>" {:noremap true :silent true})
(map :n "<leader>xd"  "<cmd>Trouble lsp_document_diagnostics<cr>" {:noremap true :silent true})
(map :n "<leader>xl"  "<cmd>Trouble loclist<cr>" {:noremap true :silent true})
(map :n "<leader>xq"  "<cmd>Trouble quickfix<cr>" {:noremap true :silent true})
(map :n "gR" "<cmd>Trouble lsp_references<cr>" {:noremap true :silent true})

(vim.cmd "highlight indent1 guifg=#E06C75 gui=nocombine")
(vim.cmd "highlight indent2 guifg=#ffffff gui=nocombine")

(map :n :j :h)
(map :n :k :j)
(map :n :ö :l)
(map :n :l :k)
(map :v :j :h)
(map :v :k :j)
(map :v :ö :l)
(map :v :l :k)

(map :n :J :H)
(map :n :K :J)
(map :n :Ö :L)
(map :n :L :K)
(map :v :J :H)
(map :v :K :J)
(map :v :Ö :L)
(map :v :L :K)

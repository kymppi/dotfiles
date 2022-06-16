(module vile-nvim
  {autoload {a aniseed.core
             nvim aniseed.nvim
             plugins dots.plugins}})

(set nvim.o.termguicolors true)
(set nvim.o.tabstop 4)
(set nvim.o.shiftwidth 4)
(set nvim.o.softtabstop 4)
(set nvim.o.expandtab true)
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader " ")
(set nvim.o.mouse :a)
(set nvim.o.number true)
(set nvim.o.relativenumber true)
(set nvim.g.indent_blankline_use_treesitter true)
(set nvim.o.cmdheight 1)
(set nvim.o.scrolloff 3)

;; Testaustime options
(set nvim.g.testaustime_url "https://api.testaustime.fi")
(set nvim.g.testaustime_token (let [f (assert (io.input "/home/midka/.config/testaustime_token"))]
                                (let [content (f:read :a)]
                                  (content:gsub "%s+" ""))))
(set nvim.g.testaustime_ignore "netrw TelescopePrompt help NeogitStatus NeogitCommitMessage NeogitPopup gitcommit packer")

(require "dots.keybinds")

(plugins.use
  ;; Starting speed
  :lewis6991/impatient.nvim {}

  ;; Fennel config support
  :Olical/aniseed {}

  ;; Lsp
  :neovim/nvim-lspconfig {:mod :lsp}

  ;; Snippets
  :L3MON4D3/LuaSnip {:mod :luasnip}
  :saadparwaiz1/cmp_luasnip {}
  :Saecki/crates.nvim {:mod :crates}

  ;; Debugger
  :mfussenegger/nvim-dap {:opt false}
  :nvim-telescope/telescope-dap.nvim {:requires [:mfussenegger/nvim-dap
                                                 :nvim-telescope/telescope.nvim]
                                      :mod :telescope}

  ;; Vanity
  :lukas-reineke/indent-blankline.nvim {:mod :indent}
  :nvim-treesitter/nvim-treesitter {:mod :treesitter}
  :petertriho/nvim-scrollbar {:mod :scrollbar}

  ;; Rust
  :rust-lang/rust.vim {:ft ["rust"]}
  :simrat39/rust-tools.nvim {}

  ;; Haskell
  :neovimhaskell/haskell-vim {:ft ["haskell"]}

  ;; Fennel
  :bakpakin/fennel.vim {:ft ["fennel"]}
  :norcalli/nvim-base16.lua {:mod :gruvbox}

  ;; Git
  :lewis6991/gitsigns.nvim {:mod :gitsigns :requires [[:nvim-lua/plenary.nvim]]}
  :TimUntersberger/neogit {:requires [[:nvim-lua/plenary.nvim]]}

  ;; Statusbar
  :nvim-lualine/lualine.nvim {:mod :lualine}
  :nvim-lua/lsp-status.nvim {}

  ;; Telescope
  :nvim-telescope/telescope.nvim {:requires [[:nvim-lua/popup.nvim] [:nvim-lua/plenary.nvim]]}
  :LinArcX/telescope-env.nvim {}
  :luc-tielen/telescope_hoogle {}

  ;; Buffer tabs
  :akinsho/bufferline.nvim {:mod :bufferline :requires [[:kyazdani42/nvim-web-devicons]]}

  ;; Icons
  :kyazdani42/nvim-web-devicons {:mod :devicons}

  ;; General editing
  :folke/trouble.nvim {:mod :trouble}
  :ggandor/lightspeed.nvim {}
  :windwp/nvim-autopairs {}
  :tpope/vim-surround {}
  :wellle/targets.vim {}
  :jghauser/mkdir.nvim {}

  ;; Testaustime
  :lajp/testaustime-nvim {:run "cabal install --overwrite-policy=always"}

  ;; nvim-cmp for completion
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-path {}
  :hrsh7th/nvim-cmp {:opt false
                     :requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-path]
                     :mod :cmp}

  :wbthomason/packer.nvim {}
  )

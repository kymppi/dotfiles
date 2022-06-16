(module dots.plugins.telescope
  {autoload {a aniseed.core
             nvim aniseed.nvim
             telescope telescope}})

(telescope.setup {})
(telescope.load_extension :env)
(telescope.load_extension :hoogle)

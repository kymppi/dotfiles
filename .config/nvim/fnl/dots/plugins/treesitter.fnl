(module dots.plugins.treesitter
  {autoload {a aniseed.core
             treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed [:rust]
   :highlight {:enable true}
   :indent {:enable true}})

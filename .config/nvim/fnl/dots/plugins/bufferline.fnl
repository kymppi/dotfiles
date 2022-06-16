(module dots.plugins.bufferline
  {autoload {a aniseed.core
             nvim aniseed.nvim
             bufferline bufferline}})

(bufferline.setup 
  {:options
   {:diagnostics :nvim_lsp
    :show_close_icon false
    :show_buffer_clone_icons false
    :separator_style :thick}})

(module dots.plugins.indent
  {autoload {a aniseed.core
             indent_blankline indent_blankline}})

(indent_blankline.setup
  {:char "|"
   :buftype_exclude 
   [:terminal]})

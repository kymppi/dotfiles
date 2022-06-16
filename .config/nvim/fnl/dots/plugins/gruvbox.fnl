(module dots.plugins.gruvbox
  {autoload {a aniseed.core
             colors dots.colors
             base16 base16}})

(let [colors (. colors :colors)]
  (base16 
    (base16.theme_from_array 
      [colors.dark0
       colors.dark1
       colors.dark2
       colors.dark3
       colors.light0
       colors.light1
       colors.light2
       colors.light3
       colors.red
       colors.orange
       colors.yellow
       colors.green
       colors.cyan
       colors.blue
       colors.purple
       colors.brown])
    false))

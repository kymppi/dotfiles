(module dots.plugins.scrollbar
  {autoload {a aniseed.core
             scrollbar scrollbar
             colors dots.colors}})

(scrollbar.setup
  {:handle
   {:color (.. "#" colors.colors.dark1)
    :text " "
    :hide_if_all_visible false}})

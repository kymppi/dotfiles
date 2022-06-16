(module dots.plugins.devicons
  {autoload {a aniseed.core
             devicons nvim-web-devicons}})

(devicons.setup 
  {:override
   {:zsh
    {:icon :
     :color :#4288502
     :name :Zsh}}
   :default true})

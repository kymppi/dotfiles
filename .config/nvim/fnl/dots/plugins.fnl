(module dots.plugins
  {autoload {a aniseed.core
             packer packer}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. "dots.plugins." name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

(defn req [name]
  (.. "require('dots.plugins." name "')"))

(defn use [...]
  (let [pkgs [...]]
    (packer.startup
      {1 (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))
       :config {:compile_path (.. (vim.fn.stdpath "config") "/lua/packer_compiled.lua")}})))

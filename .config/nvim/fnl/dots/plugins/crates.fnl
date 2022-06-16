(module dots.plugins.crates
  {autoload {a aniseed.core
             crates crates}})

(crates.setup {:avoid_prerelease false})

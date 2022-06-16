(module dots.plugins.lsp
  {autoload {a aniseed.core
             lsp lspconfig
             cmp_lsp cmp_nvim_lsp}})

(def default-capabilities
  (let [capabilities (vim.lsp.protocol.make_client_capabilities)]
    (set capabilities.textDocument.completion.completionItem.snippetSupport true)
    (cmp_lsp.update_capabilities capabilities)))

(fn init-lsp [lsp-name ?opts]
  (let [merged-opts (a.merge {:on_attach on_attach :capabilities default-capabilities} (or ?opts {}))]
    ((. lsp lsp-name :setup) merged-opts)))

(init-lsp :clangd)
(init-lsp :elixirls {:cmd ["~/elixir/language_server.sh"]})
;; (init-lsp :hls {:single_file_support true})
(init-lsp :asm_lsp)
(init-lsp :tsserver)
(init-lsp :clojure_lsp)
(init-lsp :pyright)

(let [rust-tools (require "rust-tools")]
  (rust-tools.setup {:tools {:inlay_hints {:show_parameter_hints false}
                             :autoSetHints false}
                     :server {:on_attach on_attach
                              :capabilities default-capabilities
                              :standalone true}}))

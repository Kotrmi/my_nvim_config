--Mason config 

require("mason").setup()
require("mason-lspconfig").setup {
    -- Optional: automatically install specified LSP servers
    -- ensure_installed = { "lua_ls", "pyright" },
}

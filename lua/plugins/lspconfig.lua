return {
   "neovim/nvim-lspconfig",
   config = function()
      local lsps = {
         {"rust_analyzer"},
         {"clangd"},
         {"typescript-language-server"},
         {"golangci-lint"},
      }

      for _, lsp in pairs(lsps) do
         local name,config = lsp[1], lsp[2]
         vim.lsp.enable(name)
         if config then
            vim.lsp.config(name,config)
         end
      end 
   end,
}

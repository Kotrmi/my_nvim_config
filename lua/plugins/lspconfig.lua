return {
   "neovim/nvim-lspconfig",
   config = function() 
      local lsps = {{"clangd"},{"rust_analyzer"},{"lua_ls"},{"pyright"},{"csharp_ls"}}
     
      for _, lsp in pairs(lsps) do
         local name, config = lsp[1], lsp[2]
         vim.lsp.enable(name)
         if config then
            vim.lsp.config(name,config)
         end
      end
   end,
   
}

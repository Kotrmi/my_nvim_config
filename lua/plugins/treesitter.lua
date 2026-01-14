return {
 {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({   
         ensure_installed = {"c","cpp","go","rust","python","lua","vim","vimdoc","query"},
         highlight = {
            enable = true,
         },
         indent = {enable = true},
         auto_install = true,
      })
   end,
 }
}

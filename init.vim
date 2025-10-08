call plug#begin()


"Add prettier in my vim config with plug"
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

"Add telescope with plug"
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

"Add blimk with plug"
Plug 'saghen/blink.cmp'

"Add friendly snippet with plug"

Plug 'rafamadriz/friendly-snippets'

"Add mason with plug"
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim' 


call plug#end()


"Link With mason config file"
luafile ~/.config/nvim/plugin_config/mason.lua

"Link with blink config file"
luafile ~/.config/nvim/plugin_config/blink.lua

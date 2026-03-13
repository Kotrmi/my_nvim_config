-- My nvim config

require("config.lazy")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true 
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 998

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Setup the colorizer plugin
require("colorizer").setup()


-- Setup lualine plugin 
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- Setup the inline plugin
require("tiny-inline-diagnostic").setup({
    -- Choose a preset style for diagnostic appearance
    -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
    preset = "modern",

    -- Make diagnostic background transparent
    transparent_bg = false,

    -- Make cursorline background transparent for diagnostics
    transparent_cursorline = true,

    -- Customize highlight groups for colors
    -- Use Neovim highlight group names or hex colors like "#RRGGBB"
    hi = {
        error = "DiagnosticError",     -- Highlight for error diagnostics
        warn = "DiagnosticWarn",       -- Highlight for warning diagnostics
        info = "DiagnosticInfo",       -- Highlight for info diagnostics
        hint = "DiagnosticHint",       -- Highlight for hint diagnostics
        arrow = "NonText",             -- Highlight for the arrow pointing to diagnostic
        background = "CursorLine",     -- Background highlight for diagnostics
        mixing_color = "Normal",       -- Color to blend background with (or "None")
    },

    -- List of filetypes to disable the plugin for
    disabled_ft = {},

    options = {
        -- Display the source of diagnostics (e.g., "lua_ls", "pyright")
        show_source = {
            enabled = false,           -- Enable showing source names
            if_many = false,           -- Only show source if multiple sources exist for the same diagnostic
        },

        -- Display the diagnostic code of diagnostics (e.g., "F401", "no-dupe-args")
        show_code = true,

        -- Use icons from vim.diagnostic.config instead of preset icons
        use_icons_from_diagnostic = false,

        -- Color the arrow to match the severity of the first diagnostic
        set_arrow_to_diag_color = false,


        -- Throttle update frequency in milliseconds to improve performance
        -- Higher values reduce CPU usage but may feel less responsive
        -- Set to 0 for immediate updates (may cause lag on slow systems)
        throttle = 20,

        -- Minimum number of characters before wrapping long messages
        softwrap = 30,

        -- Control how diagnostic messages are displayed
        -- NOTE: When using display_count = true, you need to enable multiline diagnostics with multilines.enabled = true
        --       If you want them to always be displayed, you can also set multilines.always_show = true.
        add_messages = {
            messages = true,           -- Show full diagnostic messages
            display_count = false,     -- Show diagnostic count instead of messages when cursor not on line
            use_max_severity = false,  -- When counting, only show the most severe diagnostic
            show_multiple_glyphs = true, -- Show multiple icons for multiple diagnostics of same severity
        },

        -- Settings for multiline diagnostics
        multilines = {
            enabled = false,           -- Enable support for multiline diagnostic messages
            always_show = false,       -- Always show messages on all lines of multiline diagnostics
            trim_whitespaces = false,  -- Remove leading/trailing whitespace from each line
            tabstop = 4,               -- Number of spaces per tab when expanding tabs
            severity = nil,            -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
          },

        -- Show all diagnostics on the current cursor line, not just those under the cursor
        show_all_diags_on_cursorline = false,

        -- Only show diagnostics when the cursor is directly over them, no fallback to line diagnostics
        show_diags_only_under_cursor = false,

        -- Display related diagnostics from LSP relatedInformation
        show_related = {
            enabled = true,           -- Enable displaying related diagnostics
            max_count = 3,             -- Maximum number of related diagnostics to show per diagnostic
        },

        -- Enable diagnostics display in insert mode
        -- May cause visual artifacts; consider setting throttle to 0 if enabled
        enable_on_insert = false,

        -- Enable diagnostics display in select mode (e.g., during auto-completion)
        enable_on_select = false,

        -- Handle messages that exceed the window width
        overflow = {
            mode = "wrap",             -- "wrap": split into lines, "none": no truncation, "oneline": keep single line
            padding = 0,               -- Extra characters to trigger wrapping earlier
        },

        -- Break long messages into separate lines
        break_line = {
            enabled = false,           -- Enable automatic line breaking
            after = 30,                -- Number of characters before inserting a line break
        },

        -- Custom function to format diagnostic messages
        -- Receives diagnostic object, returns formatted string
        -- Example: function(diag) return diag.message .. " [" .. diag.source .. "]" end
        format = nil,

        -- Virtual text display priority
        -- Higher values appear above other plugins (e.g., GitBlame)
        virt_texts = {
            priority = 2048,
        },

        -- Filter diagnostics by severity levels
        -- Remove severities you don't want to display
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },

        -- Events that trigger attaching diagnostics to buffers
        -- Default is {"LspAttach"}; change only if plugin doesn't work with your LSP setup
        overwrite_events = nil,

        -- Automatically disable diagnostics when opening diagnostic float windows
        override_open_float = false,

        -- Experimental options, subject to misbehave in future NeoVim releases
        experimental = {
          -- Make diagnostics not mirror across windows containing the same buffer
          -- See: https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/127
          use_window_local_extmarks = false,
        },
    },
})

-- Setup Keybinds to open New tab
vim.keymap.set("n","<leader>ee", ":tabnew<cr>:Neotree<cr>",{desc = "Open a new tab with Yazi"})
vim.keymap.set("n","<leader>rr", ":tabc<cr>",{desc = "Close the current tab"})
vim.keymap.set("n","<leader>tt", ":split<cr>:terminal<cr>",{desc = "Split the environment and start terminal"})

-- Setup Telescope Keybinds
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

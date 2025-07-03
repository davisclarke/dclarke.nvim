vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Background
-- Controlled by theme swticher script in /home/davisc/.config/sway
-- Ignore any changes to the line below
vim.opt.background = 'dark'

-- Conceal level
vim.opt.conceallevel = 1

-- Termgui
vim.opt.termguicolors = true

-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.numberwidth = 2
vim.opt.redrawtime = 100
vim.opt.cmdheight = 0
-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.opt.mouse = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- EOB
vim.opt.fillchars = { eob = ' ' }
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
-- vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Swap ; and :
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>w', '<cmd>:update<CR>', { desc = '[w]rite (update)' })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Buffer keymaps
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = '[d]elete buffer' })
vim.keymap.set('n', '<leader>bn', ']b', { desc = '[n]ext buffer' })
vim.keymap.set('n', '<leader>bp', '[b', { desc = '[p]revious buffer' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<PageUp>', '<cmd>echo "Use <C-u> to move!!"<CR>')
vim.keymap.set('n', '<PageDown>', '<cmd>echo "Use <C-f> to move!!"<CR>')
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- vim.api.nvim_create_user_command('GitAutoCommitPush', function()
--   local date = os.date '%Y-%m-%d %H:%M:%S'
--   local commit_cmd = string.format("git add . && git commit -m ': `date`' && git push", date)
--   local output = vim.fn.system(commit_cmd)
--   if vim.v.shell_error == 0 then
--     vim.notify('Git commit/push 󰄬 ' .. date, vim.log.levels.INFO)
--   else
--     vim.notify('Git commit/push failed: ' .. output, vim.log.levels.ERROR)
--   end
-- end, {})
-- -- Auto-update markdown
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'markdown' },
--   callback = function()
--     vim.schedule(function()
--       vim.keymap.set(
--         'n',
--         '<leader>w',
--         -- ":terminal git pull && git add . && git commit -m '`date`' && git push<CR>! :bd<CR> :echo 'Done!'<CR> ",
--         ':wa<CR>:GitAutoCommitPush<CR>',
--         { buffer = true, desc = '[w]rite all with git commit/push', noremap = true }
--       )
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex' },
  callback = function()
    vim.schedule(function()
      vim.keymap.set('n', '<leader>w', ':w<CR>:TexlabBuild<CR>', { buffer = true, desc = '[w]rite (update) and build' })
    end)
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[c]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[d]ocument' },
        { '<leader>r', group = '[r]ename' },
        { '<leader>s', group = '[s]earch' },
        { '<leader>o', group = 'w[o]rkspace' },
        { '<leader>t', group = '[t]oggle' },
        { '<leader>h', group = 'git [h]unk', mode = { 'n', 'v' } },
        { '<leader>b', group = '[b]uffer' },
      },
    },
  },
  {
    -- Fuzzy finding
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function()
      local fzflua = require 'fzf-lua'
      require('fzf-lua').setup {
        winopts = {
          backdrop = 100, -- Disable backdrop dim
          border = 'single',
          preview = {
            border = 'single',
            layout = 'flex',
          },
        },
        files = {
          fd_opts = [[--type f --hidden --follow --exclude .git --ignore-file ]] .. vim.fn.expand '$HOME/fdignore',
        },
        keymap = {
          ['ctrl-j'] = 'preview-page-down',
          ['ctrl-k'] = 'preview-page-up',
        },
      }
      vim.keymap.set('n', '<leader>sf', fzflua.files, { desc = '[s]earch [f]iles' })
      vim.keymap.set('n', '<leader>sw', fzflua.grep_cword, { desc = '[s]earch current [w]ord' })
      vim.keymap.set('n', '<leader>sg', fzflua.live_grep, { desc = '[s]earch by [g]rep' })
      vim.keymap.set('n', '<leader>sl', fzflua.grep_last, { desc = '[s]earch [l]ast grep' })
      vim.keymap.set('n', '<leader>sd', fzflua.quickfix, { desc = '[s]earch [q]uickfixes' })
      vim.keymap.set('n', '<leader>sr', fzflua.resume, { desc = '[s]earch [r]esume' })
      vim.keymap.set('n', '<leader>so', fzflua.oldfiles, { desc = '[s]earch [o]ldfiles' })
      vim.keymap.set('n', '<leader><leader>', fzflua.lgrep_curbuf, { desc = '[ ] grep current buffer' })
      vim.keymap.set('n', '<leader>sb', fzflua.buffers, { desc = '[s]earch buffers' })
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   branch = 'v3.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --     '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  --   opts = {
  --     defaults = {
  --       layout_strategy = 'horizontal',
  --       layout_config = { prompt_position = 'top' },
  --       sorting_strategy = 'ascending',
  --       winblend = 0,
  --     },
  --   },
  --   config = function()
  --     vim.keymap.set('n', '<leader>e', '<cmd>Neotree<CR>', { desc = 'Neotr[e]e' })
  --   end,
  -- },
  -- LSP Plugins
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'rust' },
        callback = function()
          vim.schedule(function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set('n', '<leader>a', function()
              vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
              -- or vim.lsp.buf.codeAction() if you don't want grouping.
            end, { silent = true, buffer = bufnr })
            vim.keymap.set(
              'n',
              'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
              function()
                vim.cmd.RustLsp { 'hover', 'actions' }
              end,
              { silent = true, buffer = bufnr }
            )
          end)
        end,
      })
    end,
  },
  -- lazy.nvim
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     window_opts = {},
  --     cmdline = {
  --       view = 'cmdline',
  --     },
  --     lsp = {
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
  --         ['vim.lsp.util.stylize_markdown'] = true,
  --         ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --       command_palette = false, -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false, -- add a border to hover docs and signature help
  --     },
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     'MunifTanjim/nui.nvim',
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     'rcarriga/nvim-notify',
  --   },
  -- },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  -- {
  --   'L3MON4D3/LuaSnip',
  --   -- follow latest release.
  --   version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --   -- install jsregexp (optional!).
  --   build = 'make install_jsregexp',
  -- },
  -- {
  --   'lervag/vimtex',
  --   lazy = false, -- lazy-loading will disable inverse search
  --   config = function()
  --     vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover
  --     vim.g.vimtex_quickfix_method = vim.fn.executable 'pplatex' == 1 and 'pplatex' or 'latexlog'
  --   end,
  --   init = function()
  --     -- VimTeX configuration goes here, e.g.
  --     vim.g.vimtex_view_method = 'zathura'
  --   end,
  --   keys = {
  --     { '<localLeader>l', '', desc = '+vimtex', ft = 'tex' },
  --   },
  -- },
  {
    'j-hui/fidget.nvim',
    tag = 'v1.0.0', -- Make sure to update this to something recent!
    opts = {
      notification = { -- NOTE: you're missing this outer table
        window = {
          winblend = 0, -- NOTE: it's winblend, not blend
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false }, menu = { scrollbar = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools toio stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim' },

      -- Allows extra capabilities provided by nvim-cmp
      -- 'hrsh7th/cmp-nvim-lsp',
      { 'saghen/blink.cmp' },
    },
    opts = {
      servers = {
        clangd = {},
        -- gopls = {},
        ruff = {},
        -- rust_analyzer = { enabled = false }, -- No need as per rustacean
        basedpyright = {
          -- use `uv` to run inside proper environment
          -- cmd = { 'uv', 'run', 'basedpyright-langserver', '--stdio' },
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = 'standard',
              },
            },
          },
        },
        texlab = {},
        marksman = {},
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          local fzflua = require 'fzf-lua'
          map('gd', fzflua.lsp_definitions, '[g]oto [d]efinition')

          -- find references for the word under your cursor.
          map('gr', fzflua.lsp_references, '[g]oto [r]eferences')

          -- jump to the implementation of the word under your cursor.
          --  useful when your language has ways of declaring types without an actual implementation.
          map('gI', fzflua.lsp_implementations, '[g]oto [I]mplementation')

          -- jump to the type of the word under your cursor.
          --  useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', fzflua.lsp_typedefs, 'type [D]efinition')

          -- fuzzy find all the symbols in your current document.
          --  symbols are things like variables, functions, types, etc.
          map('<leader>ds', fzflua.lsp_document_symbols, '[d]ocument [s]ymbols')

          -- fuzzy find all the symbols in your current workspace.
          --  similar to document symbols, except searches over your entire project.
          map('<leader>os', fzflua.lsp_live_workspace_symbols, 'w[o]rkspace [s]ymbols')

          -- rename the variable under your cursor.
          --  most language servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')

          -- execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your lsp for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })

          map('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')

          --

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle inlay [h]ints')
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      if vim.g.have_nerd_font then
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config { signs = { text = diagnostic_signs } }
      end
      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local servers = {}
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local lspconfig = require 'lspconfig'
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- require('mason-lspconfig').setup {
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       -- This handles overriding only values explicitly passed
      --       -- by the server configuration above. Useful when disabling
      --       -- certain features of an LSP (for example, turning off formatting for ts_ls)
      --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      --       require('lspconfig')[server_name].setup(server)
      --     end,
      --   },
      -- }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[f]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
  -- lazy.nvim
  { 'rktjmp/shipwright.nvim' },
  {
    'wtfox/jellybeans.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      styles = { functions = { fg = '#000000' } },
      -- plugins = { all = false },
      on_highlights = function(hl, c)
        hl.Structure = { fg = c.foreground, bold = true }
        -- hl.Special = { fg = '#00ff00', bold = true }
      end,
      on_colors = function(c)
        if vim.o.background == 'light' then
          c.background = '#f9f9f9'
          c.grey_one = '#e1e1e1'
          c.grey_three = '#dddddd'
          c.float_bg = '#e1e1e1'
          c.cocoa_brown = '#e6e6e6'
        else
          -- c.background = '#101010'
          -- c.background = '#000000'
          c.background = '#0a0a0a'
          -- c.foreground = '#d4d4d4' -- Make grey/fg the same
          -- c.grey_two = '#d4d4d4'
          -- c.total_white = '#d4d4d4'
          -- c.grey_one = '#101010'
          -- c.grey_three = '#101010'
          -- c.float_bg = '#101010'
          c.cocoa_brown = '#252525'
          c.grey_one = '#1c1c1c'
          c.grey_three = '#333333'
          c.float_bg = '#252525'
        end
      end,
    },
    init = function()
      vim.cmd [[colorscheme jellybeans ]]
      -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#252525' }) -- Change #282C34 to your desired background color
      -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#252525', fg = '#8892B0' }) -- Optional: Set border color and its background
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      --
      -- require('mini.notify').setup {
      --   lsp_progress = { duration = 2000 },
      --   window = { winblend = 100 },
      -- }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
      -- vim.opt.termguicolors = true
      require('bufferline').setup {
        options = {
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
          },
          show_buffer_close_icons = false,
          show_close_icon = false,
          indicator = { style = 'none' },
          -- auto_toggle_bufferline = true,
          always_show_bufferline = false,
          -- custom_filter = function(buf_number, buf_numbers)
          --   if buf_numbers[1] ~= buf_number then
          --     return true
          --   end
          -- end,
        },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'jellybeans',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    enabled = true,
    ---@type.Config
    opts = {
      dashboard = {
        enabled = true,
        -- Maybe later
        preset = {
          header = [[

####
  ####
    ####
       ####
       #####
       #######
       #### ####
       ####   ####
       ####     ####
       ####       ####
                             ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = "", title = "Recent Files", section = "recent_files", indent = 3, padding = 1, key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')", limit = 3 },
          { icon = "", key = "s", desc = "Last Project", section = "session", padding= 1, },
          { icon = "", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "", key = "g", desc = "Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
          -- { icon = "", key = "c", desc = "Config", action = ":e /home/davisc/.config/nvim/init.lua" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          -- { icon = "󰒲", key = "l", desc = "Lazy", action = ":Lazy" },
          -- { icon = "󰢛", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
      },
    },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
        disable = { 'latex' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>h', function()
        harpoon:list():add()
      end, { desc = 'add [h]arpoon' })
      vim.keymap.set('n', '<C-a>e', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[e]numerate harpoons' })

      vim.keymap.set('n', '<C-a>h', function()
        harpoon:list():select(1)
      end, { desc = 'harpoon 1' })
      vim.keymap.set('n', '<C-a>j', function()
        harpoon:list():select(2)
      end, { desc = 'harpoon 2' })
      vim.keymap.set('n', '<C-a>k', function()
        harpoon:list():select(3)
      end, { desc = 'harpoon 3' })
      vim.keymap.set('n', '<C-a>l', function()
        harpoon:list():select(4)
      end, { desc = 'harpoon 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-a>p', function()
        harpoon:list():prev()
      end, { desc = 'harpoon [p]revious buffer' })
      vim.keymap.set('n', '<C-a>n', function()
        harpoon:list():next()
      end, { desc = 'harpoon [n]ext buffer' })
    end,
  },
  {
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon',
    },
    cmd = {
      'RainbowDelim',
      'RainbowDelimSimple',
      'RainbowDelimQuoted',
      'RainbowMultiDelim',
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    init = function()
      require('smart-splits').setup {
        resize_mode = {
          silent = true,
          hooks = {
            on_enter = function()
              vim.notify 'Entering resize mode'
            end,
            on_leave = function()
              vim.notify 'Exiting resize mode, bye'
            end,
          },
        },
      }
    end,
  },
  -- {
  --   'epwalsh/obsidian.nvim',
  --   version = '*', -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = 'markdown',
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   -- event = {
  --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   --   -- refer to `:h file-pattern` for more examples
  --   --   "BufReadPre path/to/my-vault/*.md",
  --   --   "BufNewFile path/to/my-vault/*.md",
  --   -- },
  --   --
  --   dependencies = {
  --     -- Required.
  --     'nvim-lua/plenary.nvim',
  --     'hrsh7th/nvim-cmp',
  --     'ibhagwan/fzf-lua',
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = 'agenda',
  --         path = '~/agenda',
  --         overrides = {
  --           disable_frontmatter = true,
  --         },
  --       },
  --       {
  --         name = 'no-vault',
  --         path = function()
  --           -- alternatively use the CWD:
  --           return assert(vim.fn.getcwd())
  --           -- return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
  --         end,
  --         overrides = {
  --           notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
  --           new_notes_location = 'current_dir',
  --           templates = {
  --             folder = vim.NIL,
  --           },
  --           disable_frontmatter = true,
  --         },
  --       },
  --     },
  --     ui = {
  --       checkboxes = {
  --         [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
  --         ['x'] = { char = '', hl_group = 'ObsidianDone' },
  --       },
  --     },
  --   },
  -- },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      'ibhagwan/fzf-lua', -- optional
    },
    config = true,
    init = function()
      -- local neogit = require 'neogit'
      --
      -- neogit.setup { status = {} }
      vim.keymap.set('n', '<space>g', ':Neogit<cr>', { desc = 'Neo[g]it' })
    end,
  },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {},
  -- },

  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {
        render = 'foreground',
      }
    end,
  },

  {
    'rktjmp/lush.nvim',
    -- if you wish to use your own colorscheme:
    -- { dir = '/absolute/path/to/colorscheme', lazy = true },
  },
}, {
  ui = {},
})

-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
-- vim.opt.shell = "pwsh.exe"
-- vim.opt.shellcmdflag =
-- "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.cmd [[
-- 		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		set shellquote= shellxquote=
--   ]]

-- -- Set a compatible clipboard manager
-- vim.g.clipboard = {
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --lf",
--     ["*"] = "win32yank.exe -o --lf",
--   },
-- }

-- Get the current file's directory
local current_path = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])")

-- Modify the package path to include the current directory
package.path = package.path .. ';' .. current_path .. '?.lua'

-- Require the file from the current directory
-- local myModule = require("config\\aerial") -- Replace "myModule" with the name of your file


vim.opt.guifont = "JetBrains Mono:h13"
-- vim.cmd({ cmd = "set", args = { "guifont=JetBrains\\ Mono:h13" }, bang = true })
vim.opt.wrap = true -- bug with treesitter context

lvim.plugins = {


  {
    "smoka7/hop.nvim",
    cmd = { "HopWord" },
    opts = { keys = "etovxqpdygfblzhckisuran" },
    config = function(_, opts)
      require("hop").setup(opts)
    end,
  },
  { "nvim-pack/nvim-spectre" },
  {
    "noib3/nvim-oxi",
    config = function()
      -- require("nvim-oxi").setup()
    end,
  },
  { "vim-scripts/DoxygenToolkit.vim" },
  {
    "shumphrey/fugitive-gitlab.vim",
    config = function()
      vim.cmd([[
    let g:fugitive_gitlab_domains = ['https://gitlab.onera.net/']
    ]])
    end,
  },

  --supportera bientot gitlab pour les issues et MR
  {
    "pwntester/octo.nvim",
    -- dependencies = {
    --   -- "nvim-lua/plenary.nvim",
    --   -- "nvim-telescope/telescope.nvim",
    --   -- "nvim-tree/nvim-web-devicons",
    -- },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "Shatur/neovim-tasks",
    config = function()
      local Path = require("plenary.path")
      require("tasks").setup({
        default_params = {
          -- Default module parameters with which `neovim.json` will be created.
          cmake = {
            cmd = "cmake",                                    -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
            build_dir = tostring(Path:new("{cwd}", "build")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
            build_type = "Debug",                             -- Build type, can be changed using `:Task set_module_param cmake build_type`.
            dap_name = "lldb",                                -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
            args = {                                          -- Task default arguments.
              configure = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
            },
          },
        },
        save_before_run = false,     -- If true, all files will be saved before executing a task.
        params_file = "neovim.json", -- JSON file to store module and task parameters.
        quickfix = {
          pos = "botright",          -- Default quickfix position.
          height = 12,               -- Default height.
        },
        dap_open_command = function()
          return require("dap").repl.open()
        end, --
      })
    end,
  },
  {
    "lewis6991/nvim-treesitter-context",
    -- config = function()
    --   require("plugins.configs.nvim-treesitter-context")
    -- end,
  },
  {
    "skywind3000/asyncrun.vim",
    enabled = true,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("config.nvim-ts-rainbow")
    end,
  },
  {
    "voldikss/vim-translator",
    config = function()
      vim.api.nvim_set_var("translator_target_lang", "fr")
      vim.api.nvim_set_var("translator_source_lang", "en")
      vim.api.nvim_set_var("translator_proxy_url", "http://proxy.onera:80")
    end,
  },
  { "p00f/clangd_extensions.nvim" },
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({})
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    enabled = true,
    -- event = "VeryLazy",
    config = function()
      -- require("plugins.configs.cmakeTool")
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    -- event = "VeryLazy",
    enabled = true,
    -- config = function()
    --   require("plugins.configs.telekasten")
    -- end,
  },
  {
    "NeogitOrg/neogit",
    -- event = "VeryLazy",
    requires = "nvim-lua/plenary.nvim",
    -- config = function()
    --   require("plugins.configs.neogit")
    -- end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    -- event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  }, {
  "simnalamburt/vim-mundo",
  event = "BufEnter"
},
  {
    "rhysd/git-messenger.vim",
    event = "BufEnter",
    config = function()
      -- vim.api.nvim_command 'let g:git_messenger_include_diff="current"'
      --[[ vim.api.nvim_command("let g:git_messenger_floating_win_opts = { 'border': 'single' }") ]]
      --[[ vim.api.nvim_command("let g:git_messenger_no_default_mappings=v:true") ]]
      vim.api.nvim_command("let g:git_messenger_always_into_popup=v:true")
    end,
  },
  {
    "xolox/vim-colorscheme-switcher",
    dependencies = { "xolox/vim-misc" },
    event = "VeryLazy",
  },
  {
    "rhysd/devdocs.vim",
    config = function()
      vim.cmd([[let g:devdocs_filetype_map = {'c': 'c'} ]])
    end,
  },
  {
    "mzlogin/vim-markdown-toc",
  }, {
  "iamcco/markdown-preview.nvim",
  event = "BufEnter",
  build = "cd app && npm install",
  ft = "markdown",
  config = function()
    vim.g.mkdp_auto_start = 1
  end,
},
  {
    "sindrets/diffview.nvim",
    event = "BufEnter",
    -- event = "BufRead",
  },
  {
    "folke/trouble.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {

      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- { "lunarvim/colorschemes" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
    end,
  },

-- {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--       "MunifTanjim/nui.nvim",
--       -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
--     }
-- },
  {
    "numtostr/FTerm.nvim",
    config = function()
      require("config.fterm")
    end,
  },
}





-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- local wk = require("which-key")
-- -- wk.register({ f = {} }, {})
-- local function deregister(prefix, lhs, mode)
--   pcall(wk.register, { [lhs] = "which_key_ignore" }, { prefix = prefix })
--   pcall(vim.api.nvim_del_keymap, mode or "n", prefix .. lhs)
-- end
--
-- deregister("<leader>", "f")
-- <F2> help
-- <F2> vim-codepainter
-- <F3> vim-codepainter navigate
-- vim.g.mapleader = "<space>"
-- vim.keymap.set("n", "<F4>", ":set number! relativenumber!<CR>", { noremap = true, silent = false })
-- vim.keymap.set("n", "<F5>", ":set list! list?<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "ç", '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
vim.keymap.set("t", "ç", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })

--[[ local fterm = require("FTerm") ]]
--[[]]
--[[ local lazygit = fterm:new({ ]]
--[[     ft = 'fterm_lazygit', ]]
--[[     cmd = "lazygit" ]]
--[[ }) ]]
--[[]]
--[[  -- Use this to toggle lazygit in a floating terminal ]]
--[[ vim.keymap.set('n', '<leader>gh', function() ]]
--[[     lazygit:toggle() ]]
--[[ end) ]]
--[[]]
--[[ vim.keymap.set("n", "ç", '<CMD>ToggleTerm<CR>', { noremap = true, silent = true }) ]]
--[[ vim.keymap.set("t", "ç", '<C-\\><C-n><CMD>ToggleTerm<CR>', { noremap = true, silent = true }) ]]
--vim.cmd([[
--nnoremap <silent>ç <Cmd>exe v:count1 . "ToggleTerm"<CR>
--tnoremap <silent>ç <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
--]])

-- vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", { noremap = false, silent = true })
-- vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFileToggle<CR>", { noremap = false, silent = true })

vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<leader>ef", ":Neotree toggle reveal<CR>", { noremap = false, silent = true })

vim.keymap.set("n", "e", ":w<CR>", { noremap = false, silent = true })
-- vim.keymap.set("n", "<F8>", ":MinimapToggle<CR>", { noremap = false, silent = true })
-- vim.keymap.set("n", "<leader>nm", ":Dispatch npm start<CR>", { noremap = false, silent = false })
-- -- Buffers
--[[ vim.keymap.set("n", "<leader>bd", ":BDelete this<CR>", { noremap = false, silent = false }) ]]
-- vim.keymap.set("n", "<leader>bda", ":BDelete! all<CR>", { noremap = false, silent = false })
-- vim.keymap.set("n", "<leader>bdh", ":BDelete! hidden<CR>", { noremap = false, silent = false })
-- vim.keymap.set("n", "<leader>bn", "<Plug>(cokeline-focus-next)", { noremap = false, silent = false })
-- vim.keymap.set("n", "<leader>bp", "<Plug>(cokeline-focus-prev)", { noremap = false, silent = false })
-- -- Git
-- vim.keymap.set("n", "<leader>gf", ":20G<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = false, silent = false })
-- -- Ctrlsf
-- vim.keymap.set("n", "<C-F>f", "<Plug>CtrlSFPrompt", { noremap = false, silent = false })
-- vim.keymap.set("v", "<C-F>f", "<Plug>CtrlSFVwordExec", { noremap = false, silent = false })
-- vim.keymap.set("n", "<C-F>n", "<Plug>CtrlSFCwordExec", { noremap = false, silent = false })
-- vim.keymap.set("n", "<C-F>t", ":CtrlSFToggle<CR>", { noremap = true, silent = false })
-- -- Easy-align
-- vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = false })
-- vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = false })
-- -- Lightspeed
-- vim.keymap.set("n", "f", "<Plug>Lightspeed_f", { noremap = false, silent = false })
-- vim.keymap.set("n", "F", "<Plug>Lightspeed_F", { noremap = false, silent = false })
-- vim.keymap.set("n", "t", "<Plug>Lightspeed_t", { noremap = false, silent = false })
-- vim.keymap.set("n", "T", "<Plug>Lightspeed_T", { noremap = false, silent = false })
-- -- LSP
-- vim.keymap.set("n", "<space>,", ":lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<space>;", ":lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
--[[ vim.keymap.set("n", "ga", ":CodeActionMenu<CR>", { noremap = true, silent = true }) ]]
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gl", ":lua vim.lsp.buf.format({async=true})<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<space>m", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gS", "<cmd>Telescope lsp_document_symbols<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gk", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
-- -- Telescope
-- vim.keymap.set("n", "<leader>r", ":lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>#",
-- 	":lua require('telescope.builtin').grep_string()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set("n", "<leader>bb", ":lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>t",
-- 	":lua require('telescope.builtin').treesitter()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>l",
-- 	":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set("n", "<leader>f", "<cmd>Telescope git_files<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>p", "<cmd>Telescope projects<CR>", { noremap = true, silent = true })
-- vim.keymap.set(
--   "n",
--   "<leader>p",
--   '<cmd>lua require"telescope".extensions.project.project{ initial_mode = "normal" }<cr>',
--   opt
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>c",
-- 	":lua require('plugins.telescope').my_git_commits()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>g",
-- 	":lua require('plugins.telescope').my_git_status()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>b",
-- 	":lua require('plugins.telescope').my_git_bcommits()<CR>",
-- 	{ noremap = true, silent = true }
-- )
--[[ vim.keymap.set("n", "<leader>ns", ":lua require('plugins.telescope').my_note()<CR>", { noremap = true, silent = true }) ]]
--[[ vim.keymap.set("n", "<leader>nn", ":lua NewNote()<CR>", { noremap = true, silent = false }) ]]
vim.keymap.set("n", "<leader>nn", "<cmd>Telekasten find_notes<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>nb", "<cmd>Telekasten new_note<CR>", { noremap = true, silent = false })
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>n",
-- 	":lua require('plugins.scratches').open_scratch_file_floating()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set("n", "<leader>gc", ":Octo issue create<CR>", { noremap = true, silent = false })
-- vim.keymap.set("n", "<leader>i", ":Octo issue list<CR>", { noremap = true, silent = false })
-- vim.keymap.set("n", "<leader>y", ":Telescope neoclip<CR>", { noremap = true, silent = false })
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>ll",
-- 	":lua require('telescope.builtin').grep_string({ search = vim.fn.input('GREP -> ') })<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- -- HlsLens
-- vim.keymap.set(
-- 	"n",
-- 	"n",
-- 	"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"N",
-- 	"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.keymap.set("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
-- vim.keymap.set("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
-- vim.keymap.set("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
-- vim.keymap.set("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
-- -- Todo-comments
-- vim.keymap.set("n", "<leader>to", ":TodoTelescope<CR>", { noremap = true, silent = false })
-- -- Copilot
-- vim.keymap.set("i", "<C-J>", "copilot#Accept()", { noremap = true, silent = true, expr = true })
-- -- Move.nvim
-- vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })
-- -- Trouble
-- vim.keymap.set("n", "<leader>hh", "<cmd>Trouble<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>hw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>hd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>fxl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>hq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", { noremap = true })
-- vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<CR>", { remap = true })
-- vim.keymap.set("n", "<leader>hR", "<cmd>Trouble lsp_references<CR>", {})
-- -- Nvim-dap
-- vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dui", ":lua require('dapui').toggle()<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>duo", "<cmd>lua require'dap'.repl.open()<CR>", { silent = true, noremap = true })
vim.keymap.set(
  "n",
  "<leader>dd",
  "<cmd>lua require('dap.ext.vscode').load_launchjs(nil, { codelldb= { 'c', 'cpp' } })<CR>",
  { silent = true, noremap = true }
)
-- vim.keymap.set("n", "<leader>dlf", "<cmd>lua require('dapui').float_element()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("v", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>duu", "<cmd>lua require('dapui').update_render()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dm", "<cmd>lua require'dap'.step_back()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dap'.pause()<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>dg", "<cmd>lua require'dap'.run_to_cursor()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dq", "<cmd>e ./.vscode/launch.json<CR>", { silent = true, noremap = true })
-- vim.keymap.set(
--   "n",
--   "<leader>df",
--   "<cmd>lua require('dapui').float_element('stacks')<CR>",
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>dh",
--   "<cmd>lua require('dapui').float_element('breakpoints')<CR>",
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>dz",
--   "<cmd>lua require('dapui').float_element('repl')<CR>",
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dcc",
-- 	"<cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
-- 	{ silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>dlb",
--   "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>dv",
--   "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>df",
--   "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>",
--   { silent = true, noremap = true }
-- )

local opt = {}
-- vim.keymap.set("n", "<F5>", ":CMakeSelectBuildType<cr>", opt)
-- vim.keymap.set("n", "<F6>", ":CMakeSelectBuildTarget<cr>", opt)
-- vim.keymap.set("n", "<F7>", ":CMakeBuild --config Debug<cr>", opt)
-- vim.keymap.set("n", "<F8>", ":CMakeBuild --config Release<cr>", opt)
vim.keymap.set("n", "<F8>", ":CMakeBuild <cr>", opt)
vim.keymap.set("n", "<F5>", ":Task start cmake configure<cr>", opt)
vim.keymap.set("n", "<F6>", ":Task start cmake build_all -j10 --config Release<cr>", opt)
vim.keymap.set("n", "<F7>", ":Task start cmake build_all -j10 <cr>", opt)

-- vim.keymap.set("n", "<F5>", ":AsyncRun cmake -S . -B build<cr>", opt)
-- vim.keymap.set("n", "<F6>", ":AsyncRun cmake --build build --config Release -j10<cr>", opt)
-- vim.keymap.set("n", "<F7>", ":AsyncRun cmake --build build --config Debug -j10<cr>", opt)
vim.keymap.set("n", "<F9>", ':AsyncRun pwsh -Command "frintelcompile"<cr>', opt)
vim.keymap.set("v", "*", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], {})
-- vim.keymap.set("n", "<C-!>", ":%s/", opt)
-- vim.keymap.set("v", "<C-!>", ":s/", opt)
vim.keymap.set("n", "<C-a>", "GVgg", opt)
-- vim.keymap.set("n","<S-Insert>","<C-R>+",opt)
vim.keymap.set("n", "<leader>zvf", ":DiffviewFileHistory<cr>", opt)
vim.keymap.set("n", "<leader>zvo", ":DiffviewOpen<cr>", opt)
vim.keymap.set("n", "<leader>zd", ":DevDocsUnderCursor<cr>", opt)
-- vim.keymap.set("n", "<leader>zd",":DevDocsUnderCursor<cr>",opt)
-- vim.keymap.set("n", "<leader>zn",":edit ~/NEORG/index.norg<cr>",opt)

vim.keymap.set("n", "<leader>zx", ":only<cr>", opt)
-- vim.keymap.set("n", "<leader>za", ":tabnew<cr>", opt)
--[[ vim.keymap.set("n", "²", ":CloseAll<cr>", opt) ]]
--[[ vim.keymap.set("i", "²", "<C-o>:CloseAll<cr>", opt) ]]
--[[ vim.keymap.set("t", "²", "<C-\\><C-n>CloseAll<cr>", opt) ]]
vim.keymap.set("n", "²", ":lua QuitAllLua()<cr>", { silent = true })
vim.keymap.set("i", "²", "<C-o>:lua QuitAllLua()<cr>", { silent = true })

vim.keymap.set("t", "²", "<C-\\><C-n>:lua QuitAllLua()<cr>", { noremap = true, silent = true })

vim.keymap.set("t", "<C-a>", "<C-\\><C-n>", opt)
vim.keymap.set("t", "<C-j>", [[<DOWN>]], opt)
vim.keymap.set("t", "<C-k>", [[<UP>]], opt)
vim.keymap.set("n", "<leader>zq", "<cmd>copen<CR>", opt)
-- vim.keymap.set("n", "<F7>","<cmd>CMake build_all<CR>",opt)

vim.keymap.set("v", "*", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], opt)
vim.keymap.set("n", "<leader>zh", [[:%s/<c-r><c-w>/<c-r><c-w>/g]], opt)
vim.keymap.set("n", "<leader>zc", ":Telescope grep_string<cr>", opt)
vim.keymap.set("n", "<leader>zf", ":Telescope find_files hidden=true no_ignore=true<cr>", opt)
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files <cr>", opt)
vim.keymap.set("n", "<leader>zm", "<cmd>Glow<cr>", opt)
vim.keymap.set("n", "<leader>zp", "<cmd>MarkdownPreview<cr>", opt)
vim.keymap.set("n", "<leader>td", ":TranslateW<cr>", opt)
vim.keymap.set("v", "<leader>td", ":TranslateW<cr>", opt)
vim.keymap.set("n", "<leader>tr", ":TranslateR<cr>", opt)
vim.keymap.set("v", "<leader>tr", ":TranslateR<cr>", opt)
vim.keymap.set("n", "<leader>ta", ":TranslateW!<cr>", opt)
vim.keymap.set("v", "<leader>ta", ":TranslateW!<cr>", opt)
vim.keymap.set("n", "<leader>tz", ":TranslateR!<cr>", opt)
vim.keymap.set("v", "<leader>tz", ":TranslateR!<cr>", opt)
-- vim.keymap.set("n", "<leader>zS", ":lua require('spectre').open()<CR>", opt)
-- -- search current word
-- vim.keymap.set("n", "<leader>zsw", ":lua require('spectre').open_visual({select_word=true})<CR>", opt)
-- vim.keymap.set("v", "<leader>zss", ":lua require('spectre').open_visual()<CR>", opt)
-- -- search in current file
-- vim.keymap.set("n", "<leader>zsp", ":lua require('spectre').open_file_search()<cr>", opt)
-- vim.keymap.set("n", "<leader>znb", ":AsyncRun cpplint % <cr>", opt)

-- vim.keymap.set("n","<leader>zz",":TZFocus<cr>",opt)
vim.keymap.set("n", "<leader>zz", ":only<cr>", opt)
--[[ vim.keymap.set("n", "<leader>lm", ":Lspsaga outline<cr>", opt) ]]
vim.keymap.set("n", "<C-:>", ":Telescope commands<cr>", opt)
vim.keymap.set("n", "<C-;>", ":Telescope keymaps<cr>", opt)
vim.keymap.set("n", "<C-!>", "<cmd>Telescope command_history<cr>", opt)

-- Moving the cursor through long soft-wrapped lines
vim.keymap.set("n", "j", "gj", opt)
vim.keymap.set("n", "k", "gk", opt)

-- vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCyclePrev<cr>", opt)
-- vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCycleNext<cr>", opt)
-- vim.keymap.set("n", "<leader>bm", "<cmd>BufferLineCloseRight<cr>", opt)
-- vim.keymap.set("n", "<leader>bg", "<cmd>BufferLineCloseLeft<cr>", opt)
-- vim.keymap.set("n", "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", opt)
-- vim.keymap.set("n", "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", opt)
--
-- vim.keymap.set("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opt)
-- vim.keymap.set("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opt)
-- vim.keymap.set("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", opt)
-- vim.keymap.set("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", opt)
-- vim.keymap.set("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", opt)
-- vim.keymap.set("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", opt)
-- vim.keymap.set("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", opt)
-- vim.keymap.set("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", opt)
-- vim.keymap.set("n", "<leader>go", "<cmd>Telescope git_status<cr>", opt)
-- vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opt)
-- vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opt)
-- vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", opt)
-- vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", opt)
-- vim.keymap.set("n", "<leader>gf", "<cmd>Neogit<cr>", opt)

-- vim.keymap.set("n", "<leader>hj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opt)
-- vim.keymap.set("n", "<leader>hk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opt)
-- vim.keymap.set("n", "<leader>hS", "<cmd>Telescope lsp_document_symbols<cr>", opt)
-- vim.keymap.set("n", "<leader>hs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opt)
-- vim.keymap.set("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers({ initial_mode = "normal" })<cr>', opt)
-- vim.keymap.set("n", "<leader>hf", "<cmd>lua vim.lsp.buf.format()<cr>", opt)
-- vim.keymap.set("n", "<leader>hm", "<cmd>SymbolsOutline<cr>", opt)

-- vim.keymap.set("n", "<leader>sb", "<cmd>Telescope git_branches<cr>", opt)
-- vim.keymap.set("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>", opt)
-- vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", opt)
-- vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", opt)
-- vim.keymap.set("n", "<leader>sH", "<cmd>Telescope highlights<cr>", opt)
-- vim.keymap.set("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", opt)
-- vim.keymap.set("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "oldfiles" })
-- vim.keymap.set("n", "<leader>sR", "<cmd>Telescope registers<cr>", opt)
-- vim.keymap.set("n", "<leader>st", "<cmd>Telescope live_grep<cr>", opt)
-- vim.keymap.set("n", "<leader>ss", "<cmd>Telescope grep_string<cr>", opt)
-- vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", opt)
-- vim.keymap.set("n", "<leader>sC", "<cmd>Telescope commands<cr>", opt)
--
-- vim.keymap.set("n", "<leader>Sc", "<cmd>lua require('persistence').load()<cr>", opt)
-- vim.keymap.set("n", "<leader>Sl", "<cmd>lua require('persistence').load({ last = true })<cr>", opt)
-- vim.keymap.set("n", "<leader>SQ", "<cmd>lua require('persistence').stop()<cr>", opt)

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opt)
-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opt)
-- navigation
vim.keymap.set("i", "<A-Up>", "<C-\\><C-N><C-w>k", opt)
vim.keymap.set("i", "<A-Down>", "<C-\\><C-N><C-w>j", opt)
vim.keymap.set("i", "<A-Left>", "<C-\\><C-N><C-w>h", opt)
vim.keymap.set("i", "<A-Right>", "<C-\\><C-N><C-w>l", opt)

vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)

-- Resize with arrows
-- vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opt)
-- vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opt)
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opt)
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opt)
-- Move current line / block with Alt-j/k a la vscode.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opt)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opt)

-- QuickFix
vim.keymap.set("n", "<leader>zpj", ":cnext<CR>", opt)
vim.keymap.set("n", "<leader>zpk", ":cprev<CR>", opt)
vim.keymap.set("n", "<leader>zpo", ":copen<CR>", opt)

vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opt)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opt)
vim.keymap.set("t", "<C -k>", "<C-\\><C-N><C-w>k", opt)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opt)

-- Better indenting
vim.keymap.set("v", "<", "<gv", opt)
vim.keymap.set("v", ">", ">gv", opt)

-- Move selected line / block of text in visual mode
-- vim.keymap.set("gv","K",":move '<-2<CR>gv-gv",opt)
-- vim.keymap.set("gv","J",":move '>+1<CR>gv-gv",opt)

-- Move current line / block with Alt-j/k ala vscode.
-- vim.keymap.set("gv","<A-j>",":m '>+1<CR>gv-gv",opt)
-- vim.keymap.set("gv","<A-k>",":m '<-2<CR>gv-gv",opt)

-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
-- ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
-- ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },

--[[ vim.set.keymap("n","q","<cmd>lua require('utils.settings.functions').smart_quit()<CR>", opt) ]]

vim.keymap.set("n", "<leader>zhz", "<Cmd>ClangdSwitchSourceHeader<CR>", opt)

vim.keymap.set("c", "<S-k>", "<UP>", opt)
vim.keymap.set("c", "<S-j>", "<DOWN>", opt)
-- vim.keymap.set("n", "<leader>q", "<cmd>lua smart_quit()<cr>", opt)
--[[ vim.keymap.set("n", "<leader>q", "<cmd>lua QuitAllLua()<cr>", opt) ]]

-- vim.keymap.set("n", "<leader>gao", "<Plug>(git-conflict-ours)")
-- vim.keymap.set("n", "<leader>gat", "<Plug>(git-conflict-theirs)")
-- vim.keymap.set("n", "<leader>gab", "<Plug>(git-conflict-both)")
-- vim.keymap.set("n", "<leader>ga0", "<Plug>(git-conflict-none)")
-- vim.keymap.set("n", "<leader>gak", "<Plug>(git-conflict-prev-conflict)")
-- vim.keymap.set("n", "<leader>gaj", "<Plug>(git-conflict-next-conflict)")

-- vim.api.nvim_set_keymap("n", "<leader>gah", "<CMD>diffg RE<CR>", opt)
-- vim.api.nvim_set_keymap("n", "<leader>gab", "<CMD>diffg LO<CR>", opt)
-- vim.api.nvim_set_keymap("n", "<leader>gal", "<CMD>diffg BA<CR>", opt)

-- vim.api.nvim_set_keymap("n", "<leader>gas", "<CMD>Gdiffsplit<CR>", opt)

vim.keymap.set("n", "<leader>zvv", "<cmd>windo diffthis<cr>")
vim.keymap.set("n", "<leader>zvf", "<cmd>diffoff!<cr>")
-- vim.keymap.set("n", "<leader>ss", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
-- vim.keymap.set("n", "<F4>", "<cmd>MundoToggle<cr>")

--[[ remap recorder ]]
vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "q", "<Nop>")

-----------------------------------
--lsp saga keymap
-----------------------------------
-- vim.keymap.set("n", "gpr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- Code action
-- vim.keymap.set({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- vim.keymap.set({ "n", "v" }, "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })

-- Rename
--[[ vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true }) ]]
-- vim.keymap.set("n", "<leader>hr", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
-- vim.keymap.set("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
-- vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
-- vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
-- vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
-- vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
-- vim.keymap.set("n", "[E", function()
--   require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end, { silent = true })
-- vim.keymap.set("n", "]E", function()
--   require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end, { silent = true })

-- Outline
--[[ vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true }) ]]

-- Hover Doc
-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
-- vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- vim.keymap.set("n", "<space>ts", require("telescope").extensions.toggletasks.spawn, { desc = "toggletasks: spawn" })

vim.keymap.set("n", "<F2>", "<cmd>RandomColorScheme<CR>")

-- local opts = {}
-- vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", opts)
-- vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)
-- vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts)
--
-- vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", opts)
--
-- vim.api.nvim_set_keymap("n", "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", opts)

-- vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SReplace<CR>", {})
-- vim.api.nvim_set_keymap("n", "<leader>ra", "<CMD>SReplaceAndSave<CR>", {})
--
-- vim.api.nvim_set_keymap("n", "<leader>rz", "<CMD>MurenToggle<CR>", {})
-- vim.api.nvim_set_keymap("n", "<leader>ra", "<CMD>SReplaceAndSave<CR>", {})
-- show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

--LazyVim
-- tabs
vim.api.nvim_set_keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>e", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab><tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>b", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- vim.api.nvim_set_keymap("n","<leader>cd", vim.diagnostic.open_float, {desc = "Line Diagnostics" }),
-- vim.api.nvim_set_keymap("n,       "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" ),
-- vim.api.nvim_set_keymap("n,       "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" ),
-- vim.api.nvim_set_keymap("n,       "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" ),
-- vim.api.nvim_set_keymap("n,       "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" ),
-- vim.api.nvim_set_keymap("n,       "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" ),
-- vim.api.nvim_set_keymap("n,       "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" ),
-- vim.api.nvim_set_keymap("n,       "K", vim.lsp.buf.hover, desc = "Hover" ),
-- vim.api.nvim_set_keymap("n,       "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" ),
-- vim.api.nvim_set_keymap("n,       "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" ),
-- vim.api.nvim_set_keymap("n,       "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" ),
-- vim.api.nvim_set_keymap("n,       "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" ),
-- vim.api.nvim_set_keymap("n,       "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" ),
-- vim.api.nvim_set_keymap("n,       "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" ),
-- vim.api.nvim_set_keymap("n,       "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" ),
-- vim.api.nvim_set_keymap("n,       "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" ),
-- vim.api.nvim_set_keymap("n,       "<leader>cf", format, desc = "Format Document", has = "documentFormatting" ),
-- vim.api.nvim_set_keymap("n,       "<leader>cf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" ),
-- vim.api.nvim_set_keymap("n", "<leader>ga", vim.lsp.buf.code_action, {desc = "Code Action", mode = { "n", "v" ), has = "codeAction"} },
--       {
--         "<leader>cA",
--         function()
--           vim.lsp.buf.code_action({
--             context = {
--               only = {
--                 "source",
--               },
--               diagnostics = {},
--             },
--           })
--         end,
--         desc = "Source Action",
--         has = "codeAction",
--       }
--     }
--     if require("lazyvim.util").has("inc-rename.nvim") then
--       M._keys[#M._keys + 1] = {
--         "<leader>cr",
--         function()
--           require("inc_rename")
--           return ":IncRename " .. vim.fn.expand("<cword>")
--         end,
--         expr = true,
--         desc = "Rename",
--         has = "rename",
--       }
--     else
--       M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
--     end
--   end
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opt)
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opt)
vim.keymap.set("n", "gpc", "<cmd>lua require('goto-preview').close_all_win()<CR>", opt)
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opt)

-- vim.keymap.set("n", "<leader>l", "", { desc = "" })
-- vim.keymap.set("n", "<F2>", "<cmd>:lua require('starry.functions').toggle_style()<CR>")
-- vim.keymap.set("n", "<F3>", "<cmd>:Starry<CR>")
-- vim.keymap.set("n", "<leader>nql", ":lua require('quicknote').NewNoteAtCurrentLine()<cr>", { desc = "" })
-- vim.keymap.set("n", "<leader>nqs", ":lua require('quicknote').ShowNoteSigns()<cr>", { desc = "" })
-- -- vim.keymap.set("n", "<leader>nqls", ":lua require('quicknote').OpenNoteAtCurrentLine()", { desc = "" })
-- vim.keymap.set("n", "<leader>nqw", ":lua require('quicknote').ListNotesForCWD()<cr>", { desc = "" })

-- local opts = {noremap = true, silent = true, expr = true}
-- vim.keymap.set("n", "<leader>tp", ":lua require('pantran').motion_translate", opts)
-- vim.keymap.set("n", "<leader>to", function() return ":lua require('pantran').motion_translate()" .. "_" end, opts)
-- vim.keymap.set("x", "<leader>tp", ":lua require('pantran').motion_translate", opts)


-- vim.keymap.set("n",  "<leader>j","]",{} )
-- vim.keymap.set("n",  "<leader>k","[",{} )
vim.api.nvim_set_keymap("n", "s", "<cmd>HopChar1<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "S", "<cmd>HopWord<cr>", { silent = true })
vim.api.nvim_set_keymap("v", "s", "<cmd>HopChar1<cr>", { silent = true })
vim.api.nvim_set_keymap("v", "S", "<cmd>HopWord<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<cr>", "<cmd>HopWord<cr>", { silent = true })




vim.cmd([[
nnoremap << >>
nnoremap >> <<
vnoremap << >gv
vnoremap >> <gv
nnoremap dd "_dd
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap x "_x
vnoremap x "_x
nnoremap cc dd
nnoremap c d
vnoremap c d
noremap <Del> "_x
map! <S-Insert> <C-R>+
]])

vim.cmd([[
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
]])

vim.api.nvim_exec(
  [[

 let g:term_buf = 0
  let g:term_win = 0
let g:history_win_id = []
function! History_cursor_window()
  echomsg("history_cursor_window")
  "echomsg(g:saved_winnr_previous)
  let saved_winnr = win_getid()
    "echom(g:saved_winnr_previous)
  "if saved_winnr != g:saved_winnr_previous
    "let g:saved_winnr_previous = saved_winnr
    "echom("saved_winnr")
    "echom(saved_winnr)
    "echom("saved_winnr_prev")
    "echom(g:saved_winnr_previous)
    call add(g:history_win_id,saved_winnr)
  "endif
    "let history_win_reverse = g:history_win_id
    "call reverse(history_win_reverse)
    "call len(history_win_id)
    let indice = 0
  for elem in g:history_win_id
    let indice += 1
    "echom(indice)
      "echo(win_id2win(elem))
      echom("indoce")
      echom(indice)
    if win_id2win(g:history_win_id[-indice]) != 0
      echo("g:history_win_id[-indice]")
      echo(g:history_win_id[-indice])
      "echom(elem)
      let toto = g:history_win_id[-indice]
      echom("toto")
      echom(toto)
      return toto
    endif
  endfor
endfunction

function! Close_all()
  let nodelete = 0
  let list_file_to_delete= []
  let list_file_to_keep = ['.vimrc','vimrcWindows','Jenkinsfile','SDK_struct' ]
  if expand('%:e') !=# ''
    let nodelete = 1
  endif
  for word in list_file_to_delete
    if expand('%:e') ==# word || expand('%:t') ==# word
      let  nodelete = 0
      break
    endif
  endfor

  for word in list_file_to_keep
    if expand('%:e') ==# word || expand('%:t') ==# word
      let  nodelete = 1
      break
    endif
  endfor

  if nodelete !=# 1
    execute "bw"
  endif
endfunction

function! CloseWindo()
  "echomsg("closewindo")
  "let saved_winnr = winnr()
  "let saved_winnr = bufname()
  let saved_winnr = win_getid()
  " let saved_winnr = History_cursor_window()
  "echom saved_winnr
  "call feedkeys("\<c-c>")
  "call feedkeys("\<c-c>")
  call feedkeys("\<esc>")
  call feedkeys("\<esc>")
 "execute 'normal("CTRL-\ CTRL-N")
  pclose
  helpclose
  ccl
  "clear last pattern
  let @/ = ""
  silent! :FloatermHide!<cr>
  silent! :nohlsearch<cr>
  silent! :DiffviewClose<cr>
  silent! <cmd>ToggleTermToggleAll!<cr>
  "silent! :CocCommand explorer --quit

  "cache le terminal
  if has('nvim')
    if win_gotoid(g:term_win)
      hide
      "silent! :ToggleTermToggleAll!<cr>
    endif
  endif
  "silent! :ToggleTermToggleAll!<cr>
  windo call Close_all()
  "exec "silent! saved_winnr . 'wincmd w'"
  "exec "silent! saved_winnr . 'bufload'"
  "exec "silent! saved_winnr . 'win_gotoid'"
  "let saved_winnr = History_cursor_window()
  "echom("saved_winnr")
  "echom(saved_winnr)
  "echo saved_winnr
  call win_gotoid(saved_winnr)
  "
  "close plugin rmagatti/goto-preview
  "
silent! :lua require('goto-preview').close_all_win()
endfunction

silent! command! CloseAll call CloseWindo()
  set autoread
]],
  true
)

--[[ local M = {} ]]

function smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
  end
end

function QuitAllLua()
  vim.cmd([[call feedkeys("\<esc>")]])
  vim.cmd([[call feedkeys("q")]])
  vim.cmd([[call feedkeys("\<esc>")]])
  vim.cmd("pclose")
  vim.cmd("helpclose")
  vim.cmd("ccl")
  vim.cmd("NvimTreeClose")
  vim.cmd("DiffviewClose")
  vim.cmd("nohlsearch")
  vim.cmd("TroubleClose")
  -- vim.cmd("Neotree close")
  -- vim.cmd("SymbolsOutlineClose")
  --[[ vim.cmd("Lspsaga close_floaterm") ]]
  require("FTerm").close()
  --[[ :pclose ]]
  --[[   helpclose ]]
  --[[   ccl ]]
  require("goto-preview").close_all_win()
  require("notify").dismiss({ silent = true, pending = true })
end

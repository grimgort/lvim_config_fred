local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
telescope.setup({
  pickers = {
    buffers = {
      --[[ sort_lastused = true ]]
    },
  },
  defaults = {
    wrap_results = true,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.99,
      height = 0.99,
      preview_cutoff = 120,
    },
    -- prompt_prefix = "λ -> ",
    prompt_prefix = "   ",
    selection_caret = "|> ",
    winblend = 0,
    border = {},
    borderchars = {
      prompt = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
      -- preview = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
      -- results = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
      -- prompt = {" ", " ", " ", " ", " ", " ", " ", " "},
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    path_display = { "absolute" },
    set_env = { ["COLORTERM"] = "truecolor" },
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<A-j>"] = actions.cycle_history_next,
        ["<A-k>"] = actions.cycle_history_prev,
        ["<S-k>"] = actions.preview_scrolling_up,
        ["<S-j>"] = actions.preview_scrolling_down,
      },
      -- for normal mode
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<S-k>"] = actions.preview_scrolling_up,
        ["<S-j>"] = actions.preview_scrolling_down,
        ["<A-j>"] = actions.cycle_history_next,
        ["<A-k>"] = actions.cycle_history_prev,
        ["q"] = require("telescope.actions").close,
      },
    },
  },
  extensions = {
    --[[ fzy_native = { ]]
    --[[ 	override_generic_sorter = false, ]]
    --[[ 	override_file_sorter = true, ]]
    --[[ }, ]]
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})
-- Colors
-- #282828 #45403d #5a524c #3a3735 #504945
-- #34381b #3b4439 #402120 #4c3432 #0e363e #374141 #4f422e #3c3836
-- #e2cca9 #f2594b #f28534 #e9b143 #b0b846 #8bba7f #80aa9e #d3869b #db4740

vim.cmd([[
hi TelescopePromptBorder guifg=#f2594b guibg=#282828
hi TelescopePromptNormal  guifg=#f2594b guibg=#282828
hi TelescopePromptTitle  guifg=#f2594b guibg=#282828
hi TelescopePromptPrefix  guifg=#f2594b guibg=#282828
hi TelescopePromptCounter  guifg=#f2594b guibg=#282828

hi TelescopePreviewTitle  guifg=#8bba7f guibg=#282828
hi TelescopePreviewBorder guifg=#8bba7f guibg=#282828

hi TelescopeResultsTitle  guifg=#8bba7f guibg=#282828
hi TelescopeResultsBorder guifg=#8bba7f guibg=#282828

hi TelescopeMatching guifg=#e9b143 guibg=#282828
hi TelescopeSelection guifg=#ffffff guibg=#32302f
]])

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])
-- require("telescope.builtin").find_files({ initial_mode = "select" })
-- require("telescope.builtin").git_files({ initial_mode = "select" })

-- Extensions

-- telescope.load_extension('octo')
--[[ telescope.load_extension("fzy_native") ]]
-- require("telescope").load_extension("fzf")
--[[ telescope.load_extension('repo') ]]
--[[ telescope.load_extension("neoclip") ]]
-- telescope.load_extension("notify")
-- telescope.load_extension("dap")
-- telescope.load_extension("projects")
-- -- telescope.load_extension('live-grep-args')
--
-- -- Implement delta as previewer for diffs
--
-- local previewers = require("telescope.previewers")
-- local builtin = require("telescope.builtin")
-- local conf = require("telescope.config")
-- local M = {}
--
-- local delta = previewers.new_termopen_previewer({
--   get_command = function(entry)
--     -- this is for status
--     -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
--     -- just do an if and return a different command
--     if entry.status == "??" or "A " then
--       return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value }
--     end
--
--     -- note we can't use pipes
--     -- this command is for git_commits and git_bcommits
--     return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
--   end,
-- })
--
-- M.my_git_commits = function(opts)
--   opts = opts or {}
--   opts.previewer = delta
--
--   builtin.git_commits(opts)
-- end
--
-- M.my_git_bcommits = function(opts)
--   opts = opts or {}
--   opts.previewer = delta
--
--   builtin.git_bcommits(opts)
-- end
--
-- M.my_git_status = function(opts)
--   opts = opts or {}
--   opts.previewer = delta
--
--   builtin.git_status(opts)
-- end
--
-- M.my_note = function(opts)
--   builtin.live_grep({ prompt_title = " Note ", cwd = "~/Notes" })
-- end
--
-- M.project_files = function()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require("telescope.builtin").git_files, opts)
--   if not ok then
--     require("telescope.builtin").find_files(opts)
--   end
-- end
--
-- return M

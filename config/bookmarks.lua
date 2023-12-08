require("bookmarks").setup({
	keymap = {
		toggle = "<tab><tab>", -- toggle bookmarks
		add = "\\z", -- add bookmarks
		jump = "<CR>", -- jump from bookmarks
		delete = "dd", -- delete bookmarks
		order = "<space><space>", -- order bookmarks by frequency or updated_time
	},
    width = 0.8, -- bookmarks window width:  (0, 1]
    height = 0.6, -- bookmarks window height: (0, 1]
    preview_ratio = 0.4, -- bookmarks preview window ratio (0, 1]
    preview_ext_enable = false, -- if true, preview buf will add file ext, preview window may be highlighed(treesitter), but may be slower.
    fix_enable = false, -- if true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.
    hl_cursorline = "guibg=Gray guifg=White" -- hl bookmarsk window cursorline.
    
})

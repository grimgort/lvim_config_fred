require("neotest").setup({
  adapters = {
    --[[ ..., -- Any other adapters ]]
    --[[ require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }), ]]
    -- Or to only allow specified file types
    --[[ require("neotest-vim-test")({ allow_file_types = { "haskell", "elixir" } }), ]]
  }
})

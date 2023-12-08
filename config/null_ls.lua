require("null-ls").setup({
    --[[ sources = { ]]
    --[[     require("null-ls").builtins.formatting.stylua, ]]
        --[[ require("null-ls").builtins.formatting.fprettify, ]]
    --[[     require("null-ls").builtins.diagnostics.eslint, ]]
    --[[     -- require("null-ls").builtins.diagnostics.cppcheck, ]]
     --[[ require("null-ls").builtins.formatting.clang_format, ]]
    --[[     -- require("null-ls").builtins.completion.spell, ]]
    --[[ }, ]]
})


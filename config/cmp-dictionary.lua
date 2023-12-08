vim.cmd([[
command -nargs=1 SwitchLang call s:switch_lang('<args>')
function! s:switch_lang(lang) abort
    execute 'set spelllang=' . a:lang
    CmpDictionaryUpdate
endfunction
]])

require("cmp_dictionary").setup({
    --[[ dic = { ]]
    --[[     -- If you always use the English dictionary, The following settings are suitable: ]]
    --[[     ["*"] = "/path/to/en.dict", ]]
    --[[     spelllang = { ]]
    --[[         -- If you want to switch between English and German. ]]
    --[[         en = "/path/to/en.dict", ]]
    --[[         de = "/path/to/de.dict", ]]
    --[[     }, ]]
    --[[ }, ]]
})

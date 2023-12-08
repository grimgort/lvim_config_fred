require("mason-lspconfig").setup({
  --[[ ensure_installed = { "jsonls", "yamlls", "vimls", "clangd", "fortls", "cmake" } ]]
})

--[[ require'lspconfig'.cmake.setup{} ]]

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  --[[ ["ltex"] = function() ]]
  --[[   lspconfig.configs.ltex.setup { ]]
  --[[     default_config = { ]]
  --[[       filetypes = { 'md' }, ]]
  --[[     } ]]
  --[[   } ]]
  --[[]]
  --[[ end, ]]
  --[[ ["sumneko_lua"] = function () ]]
  --[[     lspconfig.sumneko_lua.setup { ]]
  --[[         settings = { ]]
  --[[             Lua = { ]]
  --[[                 diagnostics = { ]]
  --[[                     globals = { "vim" } ]]
  --[[                 } ]]
  --[[             } ]]
  --[[         } ]]
  --[[     } ]]
  --[[ end, ]]
})


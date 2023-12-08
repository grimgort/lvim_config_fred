require("mason").setup({
  ui = {
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  pip = {
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        install_args = { "--proxy", "https://proxy.onera:80" },
    },
})

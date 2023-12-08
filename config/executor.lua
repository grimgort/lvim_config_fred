require("executor").setup({
  -- View details of the task run in a split, rather than a popup window.
  -- Set this to `false` to use a popup.
  use_split = true,

  -- Configure the split. These are ignored if you are using a popup.
  split = {
    -- One of "top", "right", "bottom" or "left"
    position = "right",
    -- The number of columns to take up. This sets the split to 1/4 of the
    -- space. If you're using the split at the top or bottom, you could also
    -- use `vim.o.lines` to set this relative to the height of the window.
    size = math.floor(vim.o.columns * 1 / 4),
  },

  -- Configure the popup. These are ignored if you are using a split.
  popup = {
    -- Sets the width of the popup to 3/5ths of the screen's width.
    width = math.floor(vim.o.columns * 3 / 5),
    -- Sets the height to almost full height, allowing for some padding.
    height = vim.o.lines - 20,
  },

  notifications = {
    -- Show a popup notification when a task is started.
    task_started = true,
    -- Show a popup notification when a task is completed.
    task_completed = true,
  },
  preset_commands = {
    ["executor.nvim"] = {
      "cmake --build build --config Debug -j10",
    },
  },
})

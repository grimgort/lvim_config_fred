require('spectre').setup({
  replace_engine = {
    ['sed'] = {
      cmd = "sed",
      args = {},
      options = {
        ['ignore-case'] = {
          value = "--ignore-case",
          icon = "[I]",
          desc = "ignore case"
        }
      }
    },
    -- call rust code by nvim-oxi to replace
    ['oxi'] = {
      cmd = 'oxi',
      args = {},
      options = {
        ['ignore-case'] = {
          value = "i",
          icon = "[I]",
          desc = "ignore case"
        },
      }
    }
  },
  default = {
    find = {
      --pick one of item in find_engine
      cmd = "rg",
      options = { "ignore-case"}
    },
    replace = {
      --pick one of item in replace_engine
      cmd = "sed"
    }
  },
  replace_vim_cmd = "cdo",
  is_open_target_win = true, --open file on opener window
  is_insert_mode = false -- start open panel on is_insert_mode
})

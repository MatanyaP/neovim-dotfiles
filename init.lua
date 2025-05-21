vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ❶  START Lazy first
require("config.lazy")

-- ❷  THEN the rest of your config
require("config.options")
require("config.keymaps")
require("config.autocmds")

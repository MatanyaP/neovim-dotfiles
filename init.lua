-- Set leader keys BEFORE loading lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load icons first
require "icons"
-- Bootstrap configuration
require "config.lazy"

-- Load core configuration
require "config.options"
require "config.keymaps"
require "config.autocmds"

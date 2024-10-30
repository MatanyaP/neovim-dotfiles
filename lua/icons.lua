local M = {}

M.diagnostics = {
  ERROR = "",
  WARN = "",
  HINT = "",
  INFO = "",
}

M.arrows = {
  right = "",
  left = "",
  up = "",
  down = "",
}

M.symbol_kinds = {
  Array = "󰅪",
  Class = "",
  Color = "󰏘",
  Constant = "󰏿",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "󰜢",
  File = "󰈙",
  Folder = "󰉋",
  Function = "󰆧",
  Interface = "",
  Keyword = "󰌋",
  Method = "󰆧",
  Module = "",
  Operator = "󰆕",
  Property = "󰜢",
  Reference = "󰈇",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "󰀫",
}

M.misc = {
  bug = "",
  ellipsis = "…",
  git = "",
  search = "",
  vertical_bar = "│",
  dashed_bar = "┊",
}

return M

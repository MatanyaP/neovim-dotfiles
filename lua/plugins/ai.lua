return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter", -- lazy-loads in insert mode :contentReference[oaicite:14]{index=14}
		opts = { suggestion = { enabled = true }, panel = { enabled = false } },
	},
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CC" }, -- chat-style AI helper :contentReference[oaicite:15]{index=15}
		opts = { adapters = { openai = { model = "gpt-4o" } } },
	},
}

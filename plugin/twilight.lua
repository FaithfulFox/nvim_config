vim.pack.add(
	{ { src = "https://github.com/folke/twilight.nvim" } },
	{ load = false }
)

local function config()
	local twilight = require("twilight")
	twilight.setup({
		dimming = {
			alpha = 0.10,
		},
	})
end
local function load()
	if not package.loaded.twilight then
		vim.cmd.packadd("twilight.nvim")
		config()
	end
end

vim.keymap.set({ "n" }, "<leader>ut", function()
	load()
	vim.cmd.Twilight()
end, { desc = "Toggle Twilight" })

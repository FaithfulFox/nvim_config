vim.pack.add({
	{
		src = "https://github.com/oribarilan/lensline.nvim",
		tag = vim.version.range("2.x"),
	},
}, { load = false })

local icons = require("faith.icons")

local function config()
	local lensline = require("lensline")
	lensline.setup({
		providers = {
			-- Replace the default references with this enhanced version
			{
				name = "references_with_warning",
				enabled = true,
				event = { "LspAttach", "BufWritePost" },
				handler = function(bufnr, func_info, provider_config, callback)
					local utils = require("lensline.utils")

					utils.get_lsp_references(bufnr, func_info, function(references)
						if references then
							local count = #references
							local icon, text

							if count == 0 then
								icon = utils.if_nerdfont_else("⚠️ ", "WARN ")
								text = icon .. "No references"
							else
								icon = utils.if_nerdfont_else("󰌹 ", "")
								local suffix = utils.if_nerdfont_else("", " refs")
								text = icon .. count .. suffix
							end

							callback({ line = func_info.line, text = text })
						else
							callback(nil)
						end
					end)
				end,
			},
		},
		-- Profile definitions, first is default
		profiles = {
			{
				name = "basic",
				providers = {
					{
						name = "usages",
						enabled = true,
						include = { "refs", "defs", "impls" },
						breakdown = true,
					},
					{ name = "references_with_warning", enabled = true },
				},
				style = {
					render = "all",
					placement = "above",
					prefix = (icons.characters.indent):format("%s "),
					highlight = "NonText",
				},
			},
		},
	})
end

local function load()
	if not package.loaded["lensline"] then
		vim.cmd.packadd("lensline.nvim")
		config()
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	once = true,
	callback = load,
})

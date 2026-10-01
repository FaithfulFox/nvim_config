local has_luasnip, ls = pcall(require, "luasnip")
if not has_luasnip then
	return
end

local s = ls.s
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"cookm",
		fmt(
			[[
			>> [duplicate]: ref

			---
			title: {}
			source: {}
			servings: {}
			description: {}
			time.prep: {}
			time.cook: {}
			time: {}
			difficulty: {}
			category: {}
			diet: {}
			tags: {}
			---

			{}
		]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
				i(5),
				i(6),
				i(7),
				i(8),
				i(9),
				i(10),
				i(11),
				i(0),
			}
		)
	),
	s({
		trig = "@",
		name = "ingredient",
		desc = {
			"Insert ingredient notation.",
		},
		docstring = "@{1:name}{{2:quantity}%{3:unit}}{0}",
	}, fmt("@{}{{{}%{}}}{}", { i(1), i(2), i(3), i(0) })),
	s({
		trig = "#",
		name = "cookware",
		desc = {
			"Insert cookware notation.",
		},
		docstring = "#{1:name}{{}}{0}",
	}, fmt("#{}{{}}{}", { i(1), i(0) })),
}

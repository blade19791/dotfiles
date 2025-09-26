local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	-- Example: console.log snippet
	s("cl", {
		t("console.log("),
		i(1, "msg"),
		t(")"),
	}),

	-- Example: function snippet
	s("fn", {
		t("function "),
		i(1, "name"),
		t("("),
		i(2),
		t({ ") {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
}

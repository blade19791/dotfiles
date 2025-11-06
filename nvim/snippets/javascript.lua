local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- Console log
	s({ trig = "cl", dscr = "Console log" }, {
		t("console.log("),
		i(1, "variable"),
		t(");"),
	}),

	-- Function declaration
	s({ trig = "fn", dscr = "Function declaration" }, {
		t("function "),
		i(1, "functionName"),
		t("("),
		i(2),
		t(") {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- Arrow function
	s({ trig = "af", dscr = "Arrow function" }, {
		t("const "),
		i(1, "functionName"),
		t(" = ("),
		i(2),
		t(") => {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "};" }),
	}),

	-- If statement
	s({ trig = "if", dscr = "If statement" }, {
		t("if ("),
		i(1, "condition"),
		t(") {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- For loop
	s({ trig = "for", dscr = "For loop" }, {
		t("for (let "),
		i(1, "i"),
		t(" = 0; "),
		i(1, "i"),
		t(" < "),
		i(2, "length"),
		t("; "),
		i(1, "i"),
		t("++) {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- ForEach loop
	s({ trig = "fe", dscr = "ForEach loop" }, {
		t(""),
		i(1, "array"),
		t(".forEach(("),
		i(2, "item"),
		t(") => {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "});" }),
	}),

	-- Map function
	s({ trig = "map", dscr = "Array map" }, {
		t(""),
		i(1, "array"),
		t(".map(("),
		i(2, "item"),
		t(") => "),
		i(0),
		t(");"),
	}),

	-- Template literal
	s({ trig = "tl", dscr = "Template literal" }, {
		t("`${"),
		i(1, "variable"),
		t("}`"),
		i(0),
	}),

	-- Import statement
	s({ trig = "im", dscr = "Import statement" }, {
		t("import "),
		i(1, "module"),
		t(" from '"),
		i(2, "package"),
		t("';"),
	}),

	-- Export default
	s({ trig = "exd", dscr = "Export default" }, {
		t("export default "),
		i(1, "component"),
		t(";"),
	}),

	-- Try-catch block
	s({ trig = "try", dscr = "Try-catch block" }, {
		t("try {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "} catch (" }),
		i(2, "error"),
		t(") {"),
		t({ "", "\tconsole.error(" }),
		i(2, "error"),
		t(");"),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- SetTimeout
	s({ trig = "st", dscr = "SetTimeout" }, {
		t("setTimeout(() => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "}, " }),
		i(2, "1000"),
		t(");"),
	}),

	-- Promise
	s({ trig = "pr", dscr = "Promise" }, {
		t("new Promise((resolve, reject) => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "});" }),
	}),

	-- Async function
	s({ trig = "async", dscr = "Async function" }, {
		t("async function "),
		i(1, "functionName"),
		t("("),
		i(2),
		t(") {"),
		t({ "", "\ttry {" }),
		t({ "", "\t\t" }),
		i(3),
		t({ "", "\t} catch (error) {" }),
		t({ "", "\t\tconsole.error(error);" }),
		t({ "", "\t}" }),
		t({ "", "}" }),
	}),
}

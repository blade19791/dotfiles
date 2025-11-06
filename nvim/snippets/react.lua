local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- Minimal React component
	s(
		{ trig = "rfc", dscr = "Minimal React component (no import, no fragment)" },
		fmt(
			[[
      const {} = ({{{}}}) => {}

      export default {};
    ]],
			{
				i(1, "ComponentName"), -- component name
				i(2, "props"), -- destructured props
				i(0, "/* content */"), -- component body (can be JSX directly)
				rep(1), -- auto reuse component name in export
			}
		)
	),

	-- useState Hook
	s(
		{ trig = "us", dscr = "useState hook" },
		fmt(
			[[
      const [{}, set{}] = useState({});
    ]],
			{
				i(1, "state"),
				f(function(args)
					local state = args[1][1]
					return state:sub(1, 1):upper() .. state:sub(2)
				end, { 1 }),
				i(0, "initialValue"),
			}
		)
	),

	-- useEffect Hook
	s(
		{ trig = "ue", dscr = "useEffect hook" },
		fmt(
			[[
      useEffect(() => {{
        {}
      }}, [{}]);
    ]],
			{
				i(1, "// effect"),
				i(0, "dependencies"),
			}
		)
	),

	-- import React
	s({ trig = "imr", dscr = "Import React" }, t("import React from 'react';")),

	-- import useState
	s({ trig = "imus", dscr = "Import useState" }, t("import { useState } from 'react';")),

	-- import useEffect
	s({ trig = "imue", dscr = "Import useEffect" }, t("import { useEffect } from 'react';")),

	-- export component
	s({ trig = "exr", dscr = "Export React component" }, fmt("export default {};", { i(0, "ComponentName") })),

	-- useRef Hook
	s(
		{ trig = "urf", dscr = "useRef hook" },
		fmt(
			[[
      const {} = useRef({});
    ]],
			{
				i(1, "ref"),
				i(0, "null"),
			}
		)
	),

	-- Fragment shorthand
	s({ trig = "frag", dscr = "React fragment shorthand" }, fmt("<>{}</>", { i(0) })),
}

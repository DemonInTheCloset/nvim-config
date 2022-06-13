return {
	s(
		"req",
		fmt("local {} = require('{}')", {
			f(function(args)
				local modname = args[1][1] or ""
				return modname:gsub("[./]", "_")
			end, { 1 }),
			i(1),
		})
	),
	s(
		"preq",
		fmt("local {} = prequire'{}'", {
			f(function(args)
				local modname = args[1][1] or ""
				return modname:gsub("[./]", "_")
			end, { 1 }),
			i(1),
		})
	),
}

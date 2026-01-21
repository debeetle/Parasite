-- defaults
vim.g.guard_config = {
	-- format on write to buffer
	fmt_on_save = true,
	-- use lsp if no formatter was defined for this filetype
	lsp_as_default_formatter = true,
	-- whether or not to save the buffer after formatting
	save_on_fmt = true,
	-- how frequently can linters be called
	-- lint_interval = 2000,
	-- show diagnostic after format done
	refresh_diagnostic = true,
	-- auto_lint = false,
}

local ft = require("guard.filetype")
-- local lint = require("guard.lint")

-- ft("lsp"):fmt({
-- 	fn = function(bufnr, range)
-- 		vim.lsp.buf.format({ bufnr = bufnr, range = range, async = true })
-- 	end,
-- })

-- prettier has to be enable since the lsp didn't work
ft("html,css,javascript,typescript"):fmt({
	cmd = "prettier",
	args = { "--print-width", "8192", "--stdin-filepath" },
	fname = true,
	stdin = true,
})

-- ft("json"):fmt({
-- 	cmd = "prettier",
-- 	args = { "--print-width", "8192", "--stdin-filepath" },
-- 	fname = true,
-- 	stdin = true,
-- })

ft("c,cpp"):fmt({
	cmd = "clang-format",
	args = { "--style={BasedOnStyle: gnu, ColumnLimit: 0}" },
	stdin = true,
})
-- :lint({
-- 	cmd = "clang-tidy",
-- 	args = { "--quiet" },
-- 	fname = true,
-- 	parse = lint.from_regex({
-- 		source = "clang-tidy",
-- 		regex = ":(%d+):(%d+):%s+(%w+):%s+(.-)%s+%[(.-)%]",
-- 		groups = { "lnum", "col", "severity", "message", "code" },
-- 		severities = {
-- 			information = lint.severities.info,
-- 			hint = lint.severities.info,
-- 			note = lint.severities.style,
-- 		},
-- 	}),
-- })


-- ft("python"):fmt({
-- 	cmd = "ruff",
-- 	args = { "format", "-" },
-- 	stdin = true,
-- })
-- :lint({
-- 	cmd = "ruff",
-- 	args = {
-- 		"-n",
-- 		"-e",
-- 		"--output-format",
-- 		"json",
-- 		"-",
-- 		"--stdin-filename",
-- 	},
-- 	stdin = true,
-- 	fname = true,
-- 	parse = lint.from_json({
-- 		attributes = {
-- 			severity = "type",
-- 			lnum = function(js)
-- 				return js["location"]["row"]
-- 			end,
-- 			col = function(js)
-- 				return js["location"]["column"]
-- 			end,
-- 		},
-- 		severities = {
-- 			E = lint.severities.error, -- pycodestyle errors
-- 			W = lint.severities.warning, -- pycodestyle warnings
-- 			F = lint.severities.info, -- pyflakes
-- 			A = lint.severities.info, -- flake8-builtins
-- 			B = lint.severities.warning, -- flake8-bugbear
-- 			C = lint.severities.warning, -- flake8-comprehensions
-- 			T = lint.severities.info, -- flake8-print
-- 			U = lint.severities.info, -- pyupgrade
-- 			D = lint.severities.info, -- pydocstyle
-- 			M = lint.severities.into, -- Meta
-- 		},
-- 		source = "ruff",
-- 	}),
-- })

-- ft("lua"):fmt({
-- 	cmd = "stylua",
-- 	args = { "-" },
-- 	stdin = true,
-- })
-- 	:lint({
-- 	cmd = "selene",
-- 	args = { "--no-summary", "--display-style", "json2", "-" },
-- 	stdin = true,
-- 	parse = lint.from_json({
-- 		attributes = {
-- 			lnum = function(offence)
-- 				return offence.primary_label.span.start_line
-- 			end,
-- 			col = function(offence)
-- 				return offence.primary_label.span.start_column
-- 			end,
-- 		},
-- 		severities = {
-- 			Error = lint.severities.error,
-- 			Warning = lint.severities.warning,
-- 		},
-- 		lines = true,
-- 		offset = 0,
-- 		source = "selene",
-- 	}),
-- })

-- ft("sh"):fmt({
-- 	cmd = "shfmt",
-- 	stdin = true,
-- })
-- :lint({
-- 	cmd = "shellcheck",
-- 	args = { "--format", "json1", "--external-sources" },
-- 	parse = lint.from_json({
-- 		get_diagnostics = function(...)
-- 			return vim.json.decode(...).comments
-- 		end,
-- 		-- https://github.com/koalaman/shellcheck/blob/master/shellcheck.1.md
-- 		attributes = {
-- 			severity = "level",
-- 		},
-- 		source = "shellcheck",
-- 	}),
-- })

-- ft("typst"):fmt({
-- 	cmd = "typstyle",
-- 	stdin = true,
-- })
--
-- ft("fish"):fmt({
-- 	cmd = "fish_indent",
-- 	stdin = true,
-- })

-- ft("javascript"):lint({
-- 	cmd = "npx",
-- 	args = { "eslint", "--format", "json", "--stdin", "--stdin-filename" },
-- 	stdin = true,
-- 	fname = true,
-- 	parse = lint.from_json({
-- 		get_diagnostics = function(...)
-- 			return vim.json.decode(...)[1].messages
-- 		end,
-- 		attributes = {
-- 			lnum = "line",
-- 			end_lnum = "endLine",
-- 			col = "column",
-- 			end_col = "endColumn",
-- 			message = "message",
-- 			code = "ruleId",
-- 		},
-- 		severities = {
-- 			lint.severities.warning,
-- 			lint.severities.error,
-- 		},
-- 		source = "eslint",
-- 	}),
-- })

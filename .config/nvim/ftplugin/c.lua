vim.lsp.config("clangd", {
	capabilities = {
		-- offsetEncoding = { "utf-16" },
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
	},
	-- init_options = {
	-- 	fallbackFlags = { "-std=c99" },
	-- },
})
-- vim.lsp.enable("clangd")

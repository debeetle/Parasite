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
	-- 	clangdFileStatus = true,
	-- 	fallbackFlags = { "-std=c11", "-I/usr/include", "-I/usr/local/include" },
	-- },
})
-- vim.lsp.enable("clangd")
vim.treesitter.start()

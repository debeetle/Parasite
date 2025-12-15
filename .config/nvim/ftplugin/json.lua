-- local on_attach = function(client)
-- 	-- local on_attach = function(client, bufnr)
-- 	-- Disable documentHighlight capability
-- 	client.server_capabilities.documentHighlightProvider = false
-- end
--
vim.lsp.config("jsonls", {
	init_options = {
		provideFormatter = false,
	},
})
vim.lsp.enable("jsonls")

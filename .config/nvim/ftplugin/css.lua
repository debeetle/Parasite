-- vim.opt.softtabstop = 2
-- vim.opt.tabstop = 2
vim.lsp.config("cssls", {
	init_options = {
		provideFormatter = false,
	},
	settings = {
		css = {
			validate = true,
		},
		less = {
			validate = true,
		},
		scss = {
			validate = true,
		},
	},
})
vim.lsp.enable("cssls")
vim.treesitter.start()

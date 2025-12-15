vim.cmd([[
	packadd typst-preview.nvim
	"packadd cmp-path
	"packadd cmp-treesitter
	"packadd cmp-nvim-lsp
]])

require("typst-preview").setup({
	invert_colors = "never",
	dependencies_bin = {
		["tinymist"] = "/usr/bin/tinymist",
		["websocat"] = "/usr/bin/websocat",
	},
})

vim.wo.wrap = true

vim.lsp.config("tinymist", {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onSave",
		-- exportPdf = "onDocumentHasTitle",
		outputPath = "/home/chaos/typdf/$name",
		semanticTokens = "disable",
	},
})
vim.lsp.enable("tinymist")

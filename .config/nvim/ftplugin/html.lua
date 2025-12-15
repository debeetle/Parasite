vim.cmd([[
	"packadd cmp-path
	"packadd cmp-treesitter
	"packadd cmp-nvim-lsp
	set showbreak=↪   
	]])

-- vim.opt.softtabstop = 2
-- vim.opt.tabstop = 2
vim.wo.wrap = true

vim.lsp.config("html", {
	-- settings = {
	-- autoClosingTags = true,
	-- format = {
	-- 	wrapLineLength = 80,
	-- },
	init_options = {
		provideFormatter = false,
		-- 	["html.format.wrapLineLength"] = 0, -- 设置你的行宽限制，例如 80
		-- 	["html.format.wrapAttributes"] = "preserve", -- 属性换行方式
		-- 	["html.format.unformatted"] = "pre,code,textarea", -- 不格式化的标签
		-- 	["html.format.preserveNewLines"] = true, -- 保留现有换行
		-- 	["html.format.indentInnerHtml"] = true, -- 是否缩进内部HTML
	},
})
vim.lsp.enable("html")

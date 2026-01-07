#!/usr/bin/lua
require("hlsearch").setup()

-- local set_hl_for_floating_window = function()
-- 	vim.api.nvim_set_hl(0, "NormalFloat", {
-- 		link = "Normal",
-- 	})
-- 	vim.api.nvim_set_hl(0, "FloatBorder", {
-- 		bg = "none",
-- 	})
-- end
-- set_hl_for_floating_window()

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- desc = 'Avoid overwritten by loading color schemes later',
-- 	callback = set_hl_for_floating_window,
-- })

require("mini.surround").setup({
	mappings = {
		add = "ta",
		delete = "td",   -- Delete surrounding
		find = "tf",     -- Find surrounding (to the right)
		find_left = "tF", -- Find surrounding (to the left)
		highlight = "th", -- Highlight surrounding
		replace = "tr",  -- Replace surrounding
		update_n_lines = "tn", -- Update `n_lines
	},
})

require("mini.pairs").setup()

vim.api.nvim_create_user_command("Indent", function()
	require("mini.indentscope").setup({
		draw = {
			delay = 50,
			animation = require("mini.indentscope").gen_animation.none(),
		},
	})
end, {})

vim.api.nvim_create_user_command("Align", function()
	vim.cmd([[packadd mini.align]])
	require("mini.align").setup()
end, {})

vim.api.nvim_create_user_command("Hex", function()
	vim.cmd([[packadd mini.hipatterns]])
	require("mini.hipatterns").setup({
		highlighters = {
			hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
		},
	})
end, {})

-- require("nvim-dap-virtual-text").setup()

-- require("mini.animate").setup()

-- require("nvim-dap-virtual-text").setup {
--     virt_text_pos = 'inline'
-- }

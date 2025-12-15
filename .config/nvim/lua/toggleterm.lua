-- 检查是否存在至少一个终端缓冲区（无论是否在窗口中显示）
local function has_terminal_buffer()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
			return true
		end
	end
	return false
end

-- 使用示例
if has_terminal_buffer() then
	vim.api.nvim_set_keymap("t", "<M-S-t>", "<C-\\><C-n><C-w>w", { silent = true, noremap = true, nowait = true })
	vim.api.nvim_set_keymap("n", "<M-S-t>", "<C-w>wa", { silent = true, noremap = true, nowait = true })
else
	vim.api.nvim_set_keymap(
		"n",
		"<M-S-t>",
		"<CMD>vsp term://fish<CR>a",
		{ silent = true, noremap = true, nowait = true }
	)
end

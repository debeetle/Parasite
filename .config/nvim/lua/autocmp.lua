local MiniSnippets = require("mini.snippets")
local gen_loader = MiniSnippets.gen_loader
MiniSnippets.setup({
	snippets = {
		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		gen_loader.from_lang(),
	},
})

vim.o.completeopt = "menu,menuone,noinsert,popup,fuzzy"
local pumMaps = {
	["C-j"] = "<C-n>",
	["C-k"] = "<C-p>",
	["<Tab>"] = "<C-y>",
}
for insertKmap, pumKmap in pairs(pumMaps) do
	vim.keymap.set("i", insertKmap, function()
		return vim.fn.pumvisible() == 1 and pumKmap or insertKmap
	end, { expr = true })
end

-- local imap_expr = function(lhs, rhs)
-- 	vim.keymap.set("i", lhs, rhs, { expr = true })
-- end
-- imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
-- imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
--
-- _G.cr_action = function()
-- 	if vim.fn.pumvisible() ~= 0 then
-- 		-- If popup is visible, confirm selected item or add new line otherwise
-- 		local item_selected = vim.fn.complete_info()["selected"] ~= -1
-- 		return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
-- 	else
-- 		-- If popup is not visible, use plain `<CR>`. You might want to customize
-- 		-- according to other plugins. For example, to use 'mini.pairs', replace
-- 		-- next line with `return require('mini.pairs').cr()`
-- 		return keys["cr"]
-- 	end
-- end
--
-- vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		---[[Code required to activate autocompletion and trigger it on each keypress
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
		vim.api.nvim_create_autocmd({ "TextChangedI" }, {
			buffer = args.buf,
			callback = function()
				vim.lsp.completion.get()
			end,
		})
		vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		---]]

		---[[Code required to add documentation popup for an item
		local _, cancel_prev = nil, function() end
		vim.api.nvim_create_autocmd("CompleteChanged", {
			buffer = args.buf,
			callback = function()
				cancel_prev()
				local info = vim.fn.complete_info({ "selected" })
				local completionItem = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
				if nil == completionItem then
					return
				end
				_, cancel_prev = vim.lsp.buf_request(
					args.buf,
					vim.lsp.protocol.Methods.completionItem_resolve,
					completionItem,
					function(err, item, ctx)
						if not item then
							return
						end
						local docs = (item.documentation or {}).value
						local win = vim.api.nvim__complete_set(info["selected"], { info = docs })
						if win.winid and vim.api.nvim_win_is_valid(win.winid) then
							vim.treesitter.start(win.bufnr, "markdown")
							vim.wo[win.winid].conceallevel = 3
						end
					end
				)
			end,
		})
		---]]
	end,
})

require("mini.completion").setup({
	window = {
		info = { height = 30, width = 100, border = rounded },
		signature = { height = 30, width = 100, border = rounded },
	},
	lsp_completion = { source_func = 'omnifunc', auto_setup = false },
	mappings = {
		-- Force two-step/fallback completions
		force_twostep = '<C-x>Space',
		force_fallback = '<A-x>Space',

		-- Scroll info/signature window down/up. When overriding, check for
		-- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
		-- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
		scroll_down = '<C-j>',
		scroll_up = '<C-k>',
	},
})
local on_attach = function(args)
	vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
end
vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })
_G.cr_action = function()
	-- If there is selected item in popup, accept it with <C-y>
	if vim.fn.complete_info()['selected'] ~= -1 then return '\25' end
	-- Fall back to plain `<CR>`. You might want to customize according
	-- to other plugins. For example if 'mini.pairs' is set up, replace
	-- next line with `return MiniPairs.cr()`
	return '\r'
end
vim.keymap.set('i', '<CR>', 'v:lua.cr_action()', { expr = true })


local mini_snippets = require('mini.snippets')
local make_stop = function()
	local au_opts = { pattern = '*:n', once = true }
	au_opts.callback = function()
		while mini_snippets.session.get() do
			mini_snippets.session.stop()
		end
	end
	vim.api.nvim_create_autocmd('ModeChanged', au_opts)
end
local opts = { pattern = 'MiniSnippetsSessionStart', callback = make_stop }
vim.api.nvim_create_autocmd('User', opts)

local match_strict = function(snips)
	-- Do not match with whitespace to cursor's left
	return mini_snippets.default_match(snips, { pattern_fuzzy = '%S+' })
end
mini_snippets.setup({
	snippets = {
		-- Load custom file with global snippets first (adjust for Windows)
		mini_snippets.gen_loader.from_file('~/.config/nvim/snippets/*.json'),

		-- Load snippets based on current language by reading files from
		-- "snippets/" subdirectories from 'runtimepath' directories.
		mini_snippets.gen_loader.from_lang(),
	},
	mappings = { expand = '', jump_next = '', jump_prev = '' },
	expand   = { match = match_strict },
})
mini_snippets.start_lsp_server({ match = false })


require('mini.icons').setup({ style = 'ascii' })

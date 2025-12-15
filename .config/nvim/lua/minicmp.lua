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

require("mini.completion").setup({
	lsp_completion = { source_func = 'completefunc', auto_setup = false }
})

local on_attach = function(args)
	vim.bo[args.buf].completefunc = 'v:lua.MiniCompletion.completefunc_lsp'
end
vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })

_G.cr_action = function()
	-- If there is selected item in popup, accept it with <C-y>
	if vim.fn.complete_info()['selected'] ~= -1 then return '\25' end
	-- Fall back to plain `<CR>`. You might want to customize according
	-- to other plugins. For example if 'mini.pairs' is set up, replace
	-- next line with `return MiniPairs.cr()`
	return '\r'
end

vim.keymap.set('i', '<CR>', 'v:lua.cr_action()', { expr = true })

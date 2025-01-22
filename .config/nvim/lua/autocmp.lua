-- Set up nvim-cmp.
-- local has_words_before = function()
-- 	unpack = unpack or table.unpack
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local cmp = require("cmp")
vim.diagnostic.config({ signs = false }) --去除行号左边的error标识

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.snippet.expand(args.body)
			luasnip.lsp_expand(args.body)
		end,
	},
	--
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},

	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			-- maxwidth = 50,
			-- ellipsis_char = '...',
			show_labelDetails = true,
			-- menu = {
			-- 	buffer = "[Buffer]",
			-- 	nvim_lsp = "[LSP]",
			-- 	luasnip = "[LuaSnip]",
			-- },
		}),
	},

	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"c", --[[ "c" (to enable the mapping in command mode) ]]
		}),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"c", --[[ "c" (to enable the mapping in command mode) ]]
		}),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				-- if cmp.visible() then
				if cmp.visible() and cmp.get_active_entry() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						-- cmp.confirm({select = true,})
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
					end
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
			-- c = function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
			--        else
			-- 		fallback()
			--        end
			--    end
		}),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp", option = { show_autosnippets = true } },
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "buffer", option = { show_autosnippets = true } },
		{ name = "omni", option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } } },
		{ name = "nvim_lsp_signature_help", option = { show_autosnippets = true } },
		{ name = "path", option = { show_autosnippets = true } },
		-- { name = "IM", option = { show_autosnippets = true } },
		-- { name = "css-variables", option = { show_autosnippets = true } },
		{ name = "treesitter", option = { show_autosnippets = true } },
	}),
})

-- Use buffer source for `/`.
-- cmp.setup.cmdline('/', {
--     completion = { autocomplete = false },
--     sources = {
--         -- { name = 'buffer' }
--         { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
--     }
-- })

-- I don't understand but these two lines can disable the built-in tab candidate in command mode

-- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
-- 	vim.api.nvim_set_keymap('c', '<Tab>', '', { noremap = true, silent = true }),
-- 	vim.api.nvim_set_keymap('c', '<S-Tab>', '', { noremap = true, silent = true }),
-- mapping = {
-- 	["<Tab>"] = cmp.mapping(function(fallback)
-- 	  -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
-- 	if cmp.visible() then
-- 		local entry = cmp.get_selected_entry()
-- 		if not entry then
-- 			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
-- 		end
-- 		cmp.confirm()
-- 	else
-- 		fallback()
-- 	end
--    end, { "s", "c",}),
-- },
-- mapping = {
-- 	["<CR>"] = cmp.mapping({
-- 	  c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
-- 	}),
-- },
-- completion = { autocomplete = false },
--     sources = cmp.config.sources({
--         { name = 'path' }
--         }, {
--         { name = 'cmdline' }
--     })
-- })

-- configuration for cmp_im
-- require('cmp_im').setup{
-- 	enable = false,
-- 	keyword = [[\l\+]],
-- 	tables = {},
-- 	format = function(key,text) return vim.fn.print('%-15S %s',text,key) end,
-- 	maxn = 5,
-- }
-- vim.keymap.set({'n', 'v', 'c', 'i'}, '<C-S-;>', function()
--   vim.notify(string.format('IM is %s', require('cmp_im').toggle() and 'enabled' or 'disabled'))
-- end)

-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline',
-- 	option = {
-- 	ignore_cmds = {'Man','!'}
-- 	}
-- 	}
--   }),
--   matching = { disallow_symbol_nonprefix_matching = false },
-- 	-- disable cmdline completion for certain commands, such as IncRename
--   enabled = function()
--     -- Set of commands where cmp will be disabled
--     local disabled = {
--         IncRename = true
--     }
--     -- Get first word of cmdline
--     local cmd = vim.fn.getcmdline():match("%S+")
--     -- Return true if cmd isn't disabled
--     -- else call/return cmp.close(), which returns false
--     return not disabled[cmd] or cmp.close()
--   end
-- })

-- Set up lspconfig.
local on_attach = function(client)
	-- local on_attach = function(client, bufnr)
	-- Disable documentHighlight capability
	client.server_capabilities.documentHighlightProvider = false
end
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["gopls"].setup({
	cmd = { "gopls" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	init_options = {
		unPlaceholders = true,
	},
})

-- require("lspconfig").ruff.setup({
-- 	capabilities = capabilities,
-- })

require("lspconfig").jedi_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").texlab.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = false,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false,
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				args = {},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
})

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	on_init = function(client)
		-- local path = client.workspace_folders[1].name
		-- if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
		--     return
		-- end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

require("lspconfig").bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "sh", "bash", "zsh" },
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command)",
		},
	},
})

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").tinymist.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").cssls.setup({
	capabilities = vim.lsp.protocol.make_client_capabilities(),
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

require("lspconfig").html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
	single_file_support = true,
})

require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		provideFormatter = true,
	},
})
